import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String _response = '';
  List<Map<String, String>> messages = []; // Stores user and bot messages

  final String apiUrl =
      'https://63d6-35-197-142-72.ngrok-free.app/generate-response';

  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _voiceInput = '';

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speechToText.initialize();
    if (!available) {
      print("Speech-to-Text is not available");
    }
  }

  Future<void> sendMessage(String userInput) async {
    if (userInput.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "content": userInput});
    });

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_input": userInput}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          _response = jsonResponse['response'];
          messages.add({"role": "bot", "content": _response});
        });

        // Speak out the bot response
        await _speak(_response);
      } else {
        setState(() {
          _response = 'Error: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Failed to connect: $e';
      });
    }
  }

  // Method to convert text to speech
  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  // Method to listen for speech input and convert to text
  void _startListening() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speechToText.listen(onResult: (result) {
        setState(() {
          _voiceInput = result.recognizedWords;
          print("Voice Input: $_voiceInput"); // Debugging line
        });
        sendMessage(_voiceInput); // Automatically send the recognized speech
      });
    } else {
      print("Speech-to-Text initialization failed"); // Debugging line
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBuddy'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle, size: 30),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background design from the image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.jpg'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message['role'] == 'user';
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.lightBlueAccent : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft:
                                isUser ? Radius.circular(15) : Radius.zero,
                            bottomRight:
                                isUser ? Radius.zero : Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          message['content']!,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Speak button centered in the middle of the screen
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: _isListening ? _stopListening : _startListening,
                    backgroundColor: Colors.green,
                    child: Icon(
                      _isListening ? Icons.mic : Icons.record_voice_over,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
