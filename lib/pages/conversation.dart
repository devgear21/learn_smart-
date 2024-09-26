import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  String _videoUrl = '';
  VideoPlayerController? _videoController;
  bool _isLoading = false;

  // Function to send the message to FastAPI server and get the response
  // Function to send the message to FastAPI server and get the response
  Future<void> _sendMessage(String userInput) async {
    setState(() {
      _isLoading = true;
    });

    const String serverUrl =
        "https://1fba-35-197-131-157.ngrok-free.app/generate-response"; // Replace with your ngrok URL

    final Map<String, dynamic> body = {
      'user_input': userInput,
    };

    try {
      final response = await http.post(
        Uri.parse('$serverUrl/generate-response'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _response = responseData['response'];
          _videoUrl = responseData['video_url'];
        });

        await _loadAndPlayVideo(_videoUrl);
      } else {
        setState(() {
          _response = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Failed to get response: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to load and play the lipsync video
  Future<void> _loadAndPlayVideo(String videoUrl) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/lipsync_video.mp4';

      try {
        final response = await http.get(Uri.parse(videoUrl));
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        _videoController = VideoPlayerController.file(file)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      } catch (e) {
        setState(() {
          _response = "Failed to load video: $e";
        });
      }
    } else {
      setState(() {
        _response = "Storage permission denied";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation with Avatar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      final userInput = _controller.text;
                      if (userInput.isNotEmpty) {
                        _sendMessage(userInput);
                      }
                    },
              child: const Text('Send'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_response.isNotEmpty)
              Text(
                _response,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),
            if (_videoController != null &&
                _videoController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),
          ],
        ),
      ),
    );
  }
}
