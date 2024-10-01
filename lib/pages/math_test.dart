import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MathTesting extends StatefulWidget {
  final String userId;
  final VoidCallback onNextStage;

  const MathTesting(
      {super.key, required this.userId, required this.onNextStage});

  @override
  _MathTestingState createState() => _MathTestingState();
}

class _MathTestingState extends State<MathTesting> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> questions = [];
  List<String> selectedImages = [];
  String? selectedAnswer;
  List<Map<String, dynamic>> userResponses = [];
  DateTime? startTime;
  String feedback = '';
  bool showFeedback = false;
  bool testCompleted = false;
  double averageResponseTime = 0.0;
  bool startGameButton = true;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  List<Map<String, dynamic>> totalCountingQuestion = [
    {
      'question': 'Select 5 Boxes / Objects',
      'options': [
        'assets/object1/1.png',
        'assets/object1/2.png',
        'assets/object1/5.png',
        'assets/object1/9.png',
        'assets/object1/27.png',
        'assets/object1/58.png',
        'assets/object1/32.png',
        'assets/object1/number-2.png',
        'assets/object1/4.png',
      ],
      'correctAnswer': 5,
    },
    {
      'question': 'Select 3 Boxes / Objects',
      'options': [
        'assets/object2/koala.png',
        'assets/object2/elephant.png',
        'assets/object2/owl.png',
        'assets/object2/animal.png',
        'assets/object2/whale.png',
        'assets/object2/tiger.png',
        'assets/object2/chick.png',
        'assets/object2/cat.png',
        'assets/object2/crab.png',
      ],
      'correctAnswer': 3,
    },
  ];

  List<Map<String, dynamic>> totalDMASQuestion = [
    {
      'question': 'What is the right answer for 3 + 2 * 6',
      'hint': 'Use DMAS Rule',
      'options': ['30', '15', '10', '100'],
      'correctAnswer': '15',
    },
    {
      'question': 'What is the right answer for 9 - 5 * 0',
      'hint': 'Use DMAS Rule',
      'options': ['0', '15', '9', '32'],
      'correctAnswer': '9',
    },
  ];

  void handleStartGame() {
    setState(() {
      startGameButton = false;
      questions = [
        ...getRandomQuestions(totalCountingQuestion, 2),
        ...getRandomQuestions(totalDMASQuestion, 2)
      ];
      startTime = DateTime.now();
    });
  }

  List<Map<String, dynamic>> getRandomQuestions(
      List<Map<String, dynamic>> questionArray, int count) {
    questionArray.shuffle();
    return questionArray.take(count).toList();
  }

  void handleImageSelect(String option) {
    setState(() {
      if (selectedImages.contains(option)) {
        selectedImages.remove(option);
      } else {
        selectedImages.add(option);
      }
    });
  }

  void handleAnswerSelect(String? answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  Future<void> handleSubmit() async {
    final currentQuestion = questions[currentQuestionIndex];
    bool isCorrect = false;

    if (currentQuestionIndex < 2) {
      isCorrect = selectedImages.length == currentQuestion['correctAnswer'];
      selectedImages.clear();
    } else {
      isCorrect = selectedAnswer == currentQuestion['correctAnswer'];
    }

    final endTime = DateTime.now();
    final responseTime = endTime.difference(startTime!).inSeconds;

    final response = {
      'question': currentQuestion['question'],
      'correctAnswer': currentQuestion['correctAnswer'],
      'userAnswer':
          currentQuestionIndex < 2 ? selectedImages.length : selectedAnswer,
      'isCorrect': isCorrect,
      'responseTime': responseTime,
    };

    setState(() {
      userResponses.add(response);
      feedback = isCorrect ? 'Correct!' : 'Incorrect!';
      showFeedback = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        startTime = DateTime.now();
        showFeedback = false;
      });
    } else {
      final correctRatio =
          userResponses.where((res) => res['isCorrect']).length /
              questions.length;
      final avgResponseTime = userResponses.fold(0.0, (acc, res) {
            final responseTime =
                (res['responseTime'] ?? 0).toDouble(); // Cast to double
            return acc + responseTime;
          }) /
          userResponses.length;

      final finalData = {
        'userId': widget.userId,
        'responses': userResponses,
        'correctRatio': correctRatio,
        'averageResponseTime': avgResponseTime,
      };

      await users.doc(widget.userId).set({'math_testing': finalData});

      setState(() {
        averageResponseTime = avgResponseTime;
        testCompleted = true;
      });
    }
  }

  void handleRestart() {
    setState(() {
      currentQuestionIndex = 0;
      questions.clear();
      selectedImages.clear();
      selectedAnswer = null;
      userResponses.clear();
      startTime = null;
      feedback = '';
      showFeedback = false;
      testCompleted = false;
      averageResponseTime = 0.0;
      startGameButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maths Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (startGameButton)
              ElevatedButton(
                onPressed: handleStartGame,
                child: const Text('Start Game'),
              ),
            if (questions.isNotEmpty && !testCompleted) ...[
              Text(
                questions[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 20),
              ),
              if (currentQuestionIndex < 2)
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List.generate(
                      questions[currentQuestionIndex]['options'].length,
                      (index) {
                    final option =
                        questions[currentQuestionIndex]['options'][index];
                    return GestureDetector(
                      onTap: () => handleImageSelect(option),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedImages.contains(option)
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                        child: Image.asset(option, fit: BoxFit.cover),
                      ),
                    );
                  }),
                )
              else
                Column(
                  children: (questions[currentQuestionIndex]['options']
                          as List<String>)
                      .map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: selectedAnswer,
                      onChanged: handleAnswerSelect, // Pass the selected value
                    );
                  }).toList(),
                ),
              if (showFeedback)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    feedback,
                    style: TextStyle(
                      color: feedback == 'Correct!' ? Colors.green : Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: handleSubmit,
                child: const Text('Submit'),
              ),
            ],
            if (testCompleted)
              Column(
                children: [
                  const Text('Test Completed!'),
                  Text(
                      'Average Response Time: ${averageResponseTime.toStringAsFixed(2)} seconds'),
                  ElevatedButton(
                    onPressed: widget.onNextStage,
                    child: const Text('Next Stage'),
                  ),
                  ElevatedButton(
                    onPressed: handleRestart,
                    child: const Text('Restart'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
