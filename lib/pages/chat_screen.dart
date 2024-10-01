import 'dart:convert';
import 'dart:typed_data';
import 'dart:io'; // For file handling
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // For accessing device storage
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart'; // Import video player

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? userId;
  Uint8List? userImageBytes; // Image fetched from Firestore
  String? chatbotResponse;
  final TextEditingController _controller = TextEditingController();

  VideoPlayerController? _videoController; // Video player controller
  String? videoFilePath; // Path to the saved video file

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  @override
  void dispose() {
    _videoController?.dispose(); // Clean up the video controller
    super.dispose();
  }

  // Get user ID
  void _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      await _fetchUserImage();
    }
  }

  // Fetch user image from Firebase Storage
  Future<void> _fetchUserImage() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      String imageUrl = userSnapshot['imageUrl'];
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      final imageData = await ref.getData(); // Fetch the image as bytes

      setState(() {
        userImageBytes =
            imageData; // Store image bytes for lipsync video generation
      });
    } catch (e) {
      print('Error fetching user image: $e');
    }
  }

  // Send user input to FastAPI backend
  Future<void> _sendUserInput(String userInput) async {
    if (userImageBytes == null) {
      print('No user image available to send');
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://4ab0-34-125-101-253.ngrok-free.app/process'), // Your FastAPI endpoint
      );
      request.fields['user_input'] =
          userInput; // The chatbot's response or user's input
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        userImageBytes!,
        filename: 'user_image.png', // Send the image to the backend for lipsync
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseBody);

        setState(() {
          chatbotResponse =
              decodedResponse['response']; // Get the chatbot response
        });

        if (decodedResponse['video_base64'] != null) {
          Uint8List videoBytes = base64Decode(decodedResponse['video_base64']);
          await _saveAndPlayVideo(videoBytes);
        }
      } else {
        print('Error from backend: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending input to backend: $e');
    }
  }

  // Save video file to local storage and play it
  Future<void> _saveAndPlayVideo(Uint8List videoBytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/generated_video.mp4');
      await file.writeAsBytes(videoBytes); // Save video as a file
      setState(() {
        videoFilePath = file.path;
      });

      _initializeVideoPlayer(file); // Play the video
    } catch (e) {
      print('Error saving video file: $e');
    }
  }

  // Initialize video player with the saved video file
  Future<void> _initializeVideoPlayer(File videoFile) async {
    _videoController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _videoController!.play(); // Play the video once initialized
        });
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text(
          'Chat with Assistant',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 33, 150, 243),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Display chatbot response within a futuristic card
              if (chatbotResponse != null)
                Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Assistant: $chatbotResponse',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
              else
                const Text(
                  'Waiting for input...',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 33, 150, 243)),
                ),

              const SizedBox(height: 20),

              // Text field for user input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),

              // Button to send input to the chatbot
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _sendUserInput(_controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 33, 150, 243),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Display the video using VideoPlayer within a futuristic card
              if (videoFilePath != null &&
                  _videoController != null &&
                  _videoController!.value.isInitialized)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
                  ),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _videoController!.value.isPlaying
                                ? _videoController!.pause()
                                : _videoController!.play();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 33, 150, 243),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Icon(
                            _videoController!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Text(
                  'Waiting for video...',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 33, 150, 243)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
