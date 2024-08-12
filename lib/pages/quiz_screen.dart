import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;

  QuizScreen({required this.quiz});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final questions = widget.quiz['questions'] as List<dynamic>;
    final question = questions[_currentQuestionIndex] as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(question['question']),
          ),
          ...List.generate(
            (question['options'] as List<dynamic>).length,
            (index) {
              final option = question['options'][index] as String;
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Handle answer submission
              if (_currentQuestionIndex < questions.length - 1) {
                setState(() {
                  _currentQuestionIndex++;
                  _selectedOption = null;
                });
              } else {
                // Quiz is completed
                Navigator.pop(context);
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
