import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global_user.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  final String userId = GlobalUser().userId;
  Map<String, bool> earnedRewards = {};

  final List<Map<String, dynamic>> allTrophies = [
    {
      'name': 'High Accuracy - English',
      'image': 'assets/images/English_High_Accuracy.png',
      'description': 'Achieve >= 90% accuracy in English Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 0.9,
      'field': 'quiz_data_english',
    },
    {
      'name': 'Moderate Accuracy - English',
      'image': 'assets/images/English_Medium_Accuracy.png',
      'description': 'Achieve >= 50% and < 90% accuracy in English Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 0.5 && (data['accuracy'] ?? 0) < 0.9,
      'field': 'quiz_data_english',
    },
    {
      'name': 'Low Accuracy - English',
      'image': 'assets/images/English_Low_Accuracy.png',
      'description': 'Achieve < 50% in English Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) < 0.5 && (data['accuracy'] ?? 0) >= 0.1,
      'field': 'quiz_data_english',
    },
    {
      'name': 'Quick Thinker - English',
      'image': 'assets/images/English_Quick_Thinker.png',
      'description':
          'Have an average attempt time <= 20 seconds in English Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['avg_attempt_time'] ?? double.infinity) <= 20 &&
          (data['avg_attempt_time'] ?? double.infinity) >= 1.0,
      'field': 'quiz_data_english',
    },
    {
      'name': 'High Accuracy - Math',
      'image': 'assets/images/Math_High_Accuracy.png',
      'description': 'Achieve >= 90% accuracy in Math Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 0.9,
      'field': 'quiz_data_math',
    },
    {
      'name': 'Moderate Accuracy - Math',
      'image': 'assets/images/Math_Medium_Accuracy.png',
      'description': 'Achieve >= 50% and < 90% accuracy in Math Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 0.5 && (data['accuracy'] ?? 0) < 0.9,
      'field': 'quiz_data_math',
    },
    {
      'name': 'Low Accuracy - Math',
      'image': 'assets/images/Math_Low_Accuracy.png',
      'description': 'Achieve < 50% accuracy in Math Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) < 0.5 && (data['accuracy'] ?? 0) >= 0.1,
      'field': 'quiz_data_math',
    },
    {
      'name': 'Quick Thinker - Math',
      'image': 'assets/images/Math_Quick_Thinker.png',
      'description': 'Have an average attempt time <= 20 seconds in Math Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['avg_attempt_time'] ?? double.infinity) <= 20 &&
          (data['avg_attempt_time'] ?? double.infinity) >= 1.0,
      'field': 'quiz_data_math',
    },
    {
      'name': 'High Accuracy - General Education',
      'image': 'assets/images/General_High_Accuracy.png',
      'description': 'Achieve >= 90% accuracy in General Ed Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 0.9,
      'field': 'quiz_data_general_knowledge',
    },
    {
      'name': 'Moderate Accuracy - General Education',
      'image': 'assets/images/General_Medium_Accuracy.png',
      'description': 'Achieve >= 50% and < 90% accuracy in General Ed Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 0.5 && (data['accuracy'] ?? 0) < 0.9,
      'field': 'quiz_data_general_knowledge',
    },
    {
      'name': 'Low Accuracy - General Education',
      'image': 'assets/images/General_Low_Accuracy.png',
      'description': 'Achieve < 50% accuracy in General Ed Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) < 0.5 && (data['accuracy'] ?? 0) >= 0.1,
      'field': 'quiz_data_general_knowledge',
    },
    {
      'name': 'Quick Thinker - General Education',
      'image': 'assets/images/General_Quick_Thinker.png',
      'description':
          'Have an average attempt time <= 20 seconds in General Ed Quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['avg_attempt_time'] ?? double.infinity) <= 20 &&
          (data['avg_attempt_time'] ?? double.infinity) >= 1.0,
      'field': 'quiz_data_general_knowledge',
    },
    {
      'name': 'First Quiz Attempt',
      'image': 'assets/images/First_Quiz_Attempt.png',
      'description': 'Achieve at least one correct answer in any quiz.',
      'condition': (Map<String, dynamic> data) =>
          (data['accuracy'] ?? 0) >= 1.0,
      'field': 'any', // Special condition
    },
    {
      'name': 'Trophy Hunter',
      'image': 'assets/images/Grand_Trophy.png',
      'description': 'Collect all other trophies.',
      'condition': (Map<String, dynamic> data) => false,
      'field': 'trophy_hunter',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchEarnedRewards();
  }

  Future<void> _fetchEarnedRewards() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();

        if (data != null) {
          final earned = <String, bool>{};

          for (var trophy in allTrophies) {
            if (trophy['field'] == 'any') {
              // Special condition for "First Quiz Attempt"
              earned[trophy['name']] = allTrophies.any((t) {
                final fieldData = data[t['field']] ?? {};
                return t['condition'](fieldData);
              });
            } else if (trophy['field'] == 'trophy_hunter') {
              // Special condition for "Trophy Hunter"
              earned[trophy['name']] =
                  earned.values.where((value) => value == true).length ==
                      allTrophies.length - 2;
            } else {
              final fieldData = data[trophy['field']] ?? {};
              earned[trophy['name']] = trophy['condition'](fieldData);
            }
          }

          setState(() {
            earnedRewards = earned;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching rewards: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Rewards')),
      body: allTrophies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: allTrophies.length,
              itemBuilder: (context, index) {
                final trophy = allTrophies[index];
                final isEarned = earnedRewards[trophy['name']] ?? false;

                return Card(
                  elevation: 4,
                  color: isEarned ? Colors.white : Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: isEarned ? 1.0 : 0.4,
                        child: Image.asset(
                          trophy['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        trophy['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isEarned ? Colors.black : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        trophy['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: isEarned ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
