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
  String _response = '';
  bool isLoading = false;
  List<Map<String, String?>> messages = [];
  final String apiUrl =
      'https://542f-35-187-255-30.ngrok-free.app/generate-response';

  Future<void> sendMessage(String userInput) async {
    if (userInput.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "content": userInput});
      isLoading = true;
    });

    List<String> conversationHistory = messages.map((msg) {
      return "${msg['role'] == 'user' ? 'Child' : 'Chatbot'}: ${msg['content']}";
    }).toList();

    String conversationText = conversationHistory.join("\n");

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_input": userInput,
          "conversation_history": conversationText,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        String botResponse = jsonResponse['response'];
        String? imageBase64 = jsonResponse['image'];

        if (botResponse.contains('###')) {
          botResponse = botResponse.split('###')[0].trim();
        }

        setState(() {
          _response = botResponse;
          messages.add({
            "role": "bot",
            "content": _response,
            "image": imageBase64,
          });
          isLoading = false;
        });
      } else {
        setState(() {
          _response = 'Error: ${response.statusCode} - ${response.body}';
          messages.add({
            "role": "bot",
            "content": 'Something went wrong: ${response.statusCode}'
          });
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Failed to connect: $e';
        messages.add({
          "role": "bot",
          "content": 'Failed to connect. Please try again later.'
        });
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    // Accessibility settings
    final fontFamily = settings.dyslexiaFriendly ? 'OpenDyslexic' : 'Poppins';
    final textColor = settings.highContrast ? Colors.yellow : Colors.black87;
    final buttonBackgroundColor =
        settings.highContrast ? Colors.black : Colors.blueAccent;
    final backgroundColor = settings.highContrast ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatBuddy',
          style: TextStyle(
            fontFamily: fontFamily,
            color: textColor,
          ),
        ),
        backgroundColor: buttonBackgroundColor,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle, size: 30),
          ),
        ],
      ),
      body: Container(
        color: backgroundColor, // Dynamically set background color
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message['role'] == 'user';

                  return Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.lightBlueAccent : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(15),
                            topRight: const Radius.circular(15),
                            bottomLeft: isUser
                                ? const Radius.circular(15)
                                : Radius.zero,
                            bottomRight: isUser
                                ? Radius.zero
                                : const Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          message['content']!,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: textColor, // Text color changes dynamically
                            fontSize: settings.fontSize,
                          ),
                        ),
                      ),
                      if (message.containsKey('image') &&
                          message['image'] != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Image.memory(
                            base64Decode(message['image']!),
                            width: 200,
                            height: 200,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.settings_accessibility,
                      color: buttonBackgroundColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AccessibilitySettingsPage()),
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: textColor, // Adjust typing text color
                        fontSize: settings.fontSize,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type something...',
                        hintStyle: TextStyle(
                          fontFamily: fontFamily,
                          color: textColor, // Adjust hint text color
                        ),
                        fillColor: Colors.white,
                        filled: !settings.highContrast,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    backgroundColor: buttonBackgroundColor,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
