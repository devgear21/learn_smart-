import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learnsmart/pages/accessibilty_settings_page.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  String? _generatedImageBase64;
  bool isLoading = false;
  final String apiUrl = 'https://306d-34-82-41-213.ngrok-free.app/chat';
  String sessionId = "user-session-1";

  Future<void> sendMessage(String userInput) async {
    if (userInput.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "content": userInput});
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "session_id": sessionId,
          "message": userInput,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        setState(() {
          messages.add({
            "role": "assistant",
            "content":
                cleanResponse(jsonResponse['assistant_reply'] ?? "No response")
          });
          _generatedImageBase64 = jsonResponse['image'];
          isLoading = false;
        });
      } else {
        setState(() {
          messages.add({
            "role": "assistant",
            "content": "Error: ${response.statusCode} - ${response.body}"
          });
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"role": "assistant", "content": "Failed to connect: $e"});
        isLoading = false;
      });
    }
  }

  String cleanResponse(String response) {
    return response.split('#').first.trim();
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
      appBar: AppBar(
        title: Text(
          '          ChatBuddy',
          style: TextStyle(
            fontFamily: fontFamily,
            color: textColor,
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
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Conversation Display
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message["role"] == "user";
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isUser
                              ? buttonColor
                              : (settings.highContrast
                                  ? Colors.grey[800]
                                  : Colors.grey[300]),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          message["content"]!,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: isUser ? Colors.white : textColor,
                            fontSize: settings.fontSize,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Image Display (if available)
              if (_generatedImageBase64 != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textColor, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        base64Decode(_generatedImageBase64!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              // Input and Send Button
              if (isLoading)
                const CircularProgressIndicator()
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: textColor,
                          fontSize: settings.fontSize,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: textColor,
                          ),
                          fillColor: settings.highContrast
                              ? Colors.grey[900]
                              : Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: Colors.white,
                          fontSize: settings.fontSize,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
