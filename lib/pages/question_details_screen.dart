import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import '../global_user.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:core';
import 'dart:developer' as developer;

class QuestionDetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final Map<String, dynamic> childData;
  final String currentSubject;

  const QuestionDetailScreen({
    super.key,
    required this.questions,
    required this.childData,
    required this.currentSubject,
  });

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  late Map<String, dynamic> currentQuestion;
  String? selectedOption, currentDifficulty, trainFlag = 'false';
  TextEditingController textController = TextEditingController();
  int questionsAttempted = 0;
  int correctAnswers = 0;
  double totalAttemptTime = 0.0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Stopwatch _stopwatch = Stopwatch(); // Declare Stopwatch

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _selectRandomQuestion();
  }

  @override
  void dispose() {
    textController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _selectRandomQuestion() {
    final randomIndex = Random().nextInt(widget.questions.length);
    setState(() {
      currentQuestion = widget.questions[randomIndex];
      selectedOption = null;
      textController.clear();
    });
  }

  Future<void> _makeSaveApiRequest() async {
    try {
      final quizData = {
        "total_questions_attempted": questionsAttempted,
        "correct_answers": correctAnswers,
        "accuracy": correctAnswers / questionsAttempted,
        "avg_attempt_time": totalAttemptTime / questionsAttempted,
        "train": trainFlag,
      };

      final userId = GlobalUser().userId;

      int difficultyValue;
      switch (currentDifficulty) {
        case 'Easy':
          difficultyValue = 0;
          break;
        case 'Medium':
          difficultyValue = 1;
          break;
        case 'Hard':
          difficultyValue = 2;
          break;
        default:
          difficultyValue = 1;
      }

      String quizDataField = "";
      if (widget.currentSubject == "English") {
        quizDataField = "quiz_data_english";
      } else if (widget.currentSubject == "Math") {
        quizDataField = "quiz_data_math";
      } else if (widget.currentSubject == "General Knowledge") {
        quizDataField = "quiz_data_general_knowledge";
      }

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final childData = userDocSnapshot.data()?['child_data'] ?? {};
        final transitionHistory =
            List<int>.from(childData['transition_history'] ?? []);

        if (transitionHistory.length >= 5) {
          transitionHistory.removeAt(0);
        }

        transitionHistory.add(difficultyValue);

        await userDocRef.update({
          quizDataField: quizData,
          'child_data.current_difficulty': currentDifficulty ?? 'Medium',
          'child_data.transition_history': transitionHistory,
        });
      } else {
        developer.log("User document not found");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  Future<void> _makeApiRequest() async {
    try {
      final updatedChildData = {
        ...widget.childData, // Existing child_data keys
        "current_subject": widget.currentSubject, // Add current_subject key
      };
      final quizData = {
        "total_questions_attempted": questionsAttempted,
        "correct_answers": correctAnswers,
        "accuracy": correctAnswers / questionsAttempted,
        "avg_attempt_time": totalAttemptTime / questionsAttempted,
        "train": trainFlag,
      };

      final requestData = {
        "child_data": updatedChildData,
        "quiz_data": quizData,
      };
      developer.log(requestData.toString());
      //LINK
      final response = await http.post(
        Uri.parse('https://aee7-39-60-190-11.ngrok-free.app/get-difficulty'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentDifficulty = data['difficulty'];

        // Query new questions based on predictedDifficulty
        await _fetchQuestionsForDifficulty(currentDifficulty);
      } else {
        throw Exception('Failed to fetch predicted difficulty');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching new difficulty: $e')),
      );
    }
  }

  Future<void> _fetchQuestionsForDifficulty(difficulty) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('subjects')
          .doc(widget.currentSubject) // Use the passed subject
          .collection('difficultyLevels')
          .doc(difficulty.toLowerCase())
          .collection('questions')
          .get();

      final newQuestions = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      setState(() {
        widget.questions.clear();
        widget.questions.addAll(newQuestions);
        _selectRandomQuestion();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching questions: $e')),
      );
    }
  }

  void _checkAnswer() async {
    final correctOption = currentQuestion['correct_option'];
    final userAnswer = currentQuestion['type'] == 'multiple_choice' ||
            currentQuestion['type'] == 'image'
        ? selectedOption
        : textController.text;

    if (userAnswer == null || userAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide an answer')),
      );
      return;
    }

    setState(() {
      questionsAttempted += 1;
      totalAttemptTime += _stopwatch.elapsedMilliseconds / 1000;
      if (userAnswer == correctOption) {
        correctAnswers += 1;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correct Answer!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect. The correct answer is: $correctOption'),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (questionsAttempted % 2 == 0) {
        trainFlag = 'true';
        _makeApiRequest();
      } else {
        trainFlag = 'false';
      }
      if (questionsAttempted == 20) {
        _stopwatch.stop();
        _makeSaveApiRequest();
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz Complete!'),
            backgroundColor: Color.fromARGB(255, 175, 135, 76),
          ),
        );
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      _selectRandomQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lesson =
        currentQuestion['lesson']?['content'] as List<dynamic>? ?? [];
    final questionText = currentQuestion['question'] ?? 'No question available';
    final options = currentQuestion['options'] as List<dynamic>? ?? [];
    final type = currentQuestion['type'] ?? 'unknown';

    return Scaffold(
      appBar: AppBar(title: const Text('Question Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lesson:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (var content in lesson)
              if (content['type'] == 'text')
                Text(
                  content['content'] ?? '',
                  style: const TextStyle(fontSize: 16),
                )
              else if (content['type'] == 'image')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(
                    content['url'] ?? '',
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Image could not be loaded'),
                  ),
                )
              else if (content['type'] == 'audio')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(content['description'] ?? 'Audio Description'),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: () async {
                          await _audioPlayer.play(UrlSource(content['url']));
                        },
                        child: const Text('Play Audio'),
                      ),
                    ],
                  ),
                ),
            const SizedBox(height: 16),
            Text(
              'Question: $questionText',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (type == 'multiple_choice')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Options:',
                    style: TextStyle(fontSize: 16),
                  ),
                  ...options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            if (type == 'image')
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ...options.map((imageUrl) {
                  return ListTile(
                    title: Image.network(
                      imageUrl,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Image could not be loaded'),
                    ),
                    leading: Radio<String>(
                      value: imageUrl,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                  );
                }).toList(),
              ]),
            if (type == 'text')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Answer:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your answer here',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
