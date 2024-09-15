import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _controller = TextEditingController();
  String _response = '';
  bool isLoading = false; // To show a loading indicator during API request
  List<Map<String, String>> messages = []; // Stores user and bot messages

  final String apiUrl =
      'https://7ba1-34-141-140-22.ngrok-free.app/generate-response'; // Replace with your API URL

  // Function to send the user's message to the chatbot and get the response
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

        // Extract the response and remove unnecessary text
        String botResponse = jsonResponse['response'];

        // Remove unnecessary parts (anything after ###)
        if (botResponse.contains('###')) {
          botResponse = botResponse.split('###')[0].trim();
        }

        setState(() {
          _response = botResponse;
          messages.add({"role": "bot", "content": _response});
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
              if (isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.mic, color: Colors.deepPurpleAccent),
                      onPressed: () {
                        // Add microphone functionality if needed
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type something...',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    FloatingActionButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
