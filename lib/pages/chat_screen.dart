import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learnsmart/pages/accessibilty_settings_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? userId;
  Uint8List? userImageBytes;
  String? chatbotResponse;
  Uint8List? generatedImageBytes;
  final TextEditingController _controller = TextEditingController();

  VideoPlayerController? _videoController;
  String? videoFilePath;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      await _fetchUserImage();
    }
  }

  Future<void> _fetchUserImage() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      String imageUrl = userSnapshot['imageUrl'];
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      final imageData = await ref.getData();

      setState(() {
        userImageBytes = imageData;
      });
    } catch (e) {
      print('Error fetching user image: $e');
    }
  }

  Future<void> _sendUserInput(String userInput) async {
    if (userImageBytes == null) {
      print('No user image available to send');
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://ad16-34-124-247-25.ngrok-free.app/process'), // Replace with actual URL
      );
      request.fields['user_input'] = userInput;
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        userImageBytes!,
        filename: 'user_image.png',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseBody);

        setState(() {
          chatbotResponse = decodedResponse['response'];
          generatedImageBytes = decodedResponse['image_base64'] != null
              ? base64Decode(decodedResponse['image_base64'])
              : null;
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

  Future<void> _saveAndPlayVideo(Uint8List videoBytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/generated_video.mp4');
      await file.writeAsBytes(videoBytes);
      setState(() {
        videoFilePath = file.path;
      });

      _initializeVideoPlayer(file);
    } catch (e) {
      print('Error saving video file: $e');
    }
  }

  Future<void> _initializeVideoPlayer(File videoFile) async {
    _videoController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _videoController!.play();
        });
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    // Accessibility settings
    final fontFamily = settings.dyslexiaFriendly ? 'OpenDyslexic' : 'Poppins';
    final textColor = settings.highContrast ? Colors.yellow : Colors.black87;
    final backgroundColor = settings.highContrast ? Colors.black : Colors.white;
    final buttonColor =
        settings.highContrast ? Colors.black : Colors.blueAccent;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          '                FaceBuddy',
          style: TextStyle(
            fontFamily: fontFamily,
            color: textColor,
            fontSize: settings.fontSize + 2,
          ),
        ),
        backgroundColor: buttonColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_accessibility,
              color: settings.highContrast ? Colors.yellow : Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccessibilitySettingsPage()),
              );
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (chatbotResponse != null)
                Card(
                  color: backgroundColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: buttonColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Assistant: $chatbotResponse',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: settings.fontSize,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              if (generatedImageBytes != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: 200, // Set the desired width
                    height: 200, // Set the desired height
                    child: Image.memory(
                      generatedImageBytes!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: textColor,
                    fontSize: settings.fontSize,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter your message',
                    labelStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: textColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: backgroundColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _sendUserInput(_controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: settings.fontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (videoFilePath != null &&
                  _videoController != null &&
                  _videoController!.value.isInitialized)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: buttonColor),
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
                            backgroundColor: buttonColor,
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
                Text(
                  'Waiting for video...',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: settings.fontSize,
                    color: textColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
