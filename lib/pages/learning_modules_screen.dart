import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lessons_screen.dart';
import './question_details_screen.dart';
import '../global_user.dart';
import 'dart:developer' as developer;

class LearningModulesScreen extends StatelessWidget {
  final String userId =
      GlobalUser().userId; // User ID passed from the previous screen
  final String subject;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LearningModulesScreen({super.key, required this.subject});

  // Fetch current difficulty of the user from 'users' collection
  Future<Map<String, dynamic>> _fetchChildData() async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final childData =
            userDoc.data()?['child_data'] as Map<String, dynamic>? ?? {};
        // return childData['current_difficulty'] ?? 'medium'; // Default to medium
        return childData;
      }
    } catch (e) {
      print('Error fetching current difficulty: $e');
    }
    return {}; // Default to 'medium' if error occurs
  }

  // Fetch modules based on subject and difficulty level
  Future<List<Map<String, dynamic>>> _fetchModules(
      String subjectId, String difficultyLevel) async {
    try {
      final modulesRef = _firestore
          .collection('subjects')
          .doc(subjectId)
          .collection('difficultyLevels')
          .doc(difficultyLevel)
          .collection('modules');

      final snapshot = await modulesRef.get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      // For each module, fetch questions subcollection
      final modules = await Future.wait(snapshot.docs.map((moduleDoc) async {
        final moduleTitle = moduleDoc.id;

        // Fetch questions subcollection
        final questionsRef =
            modulesRef.doc(moduleTitle).collection('questions');
        final questionsSnapshot = await questionsRef.get();

        final questions = questionsSnapshot.docs.map((questionDoc) {
          final questionData = questionDoc.data();
          return {
            'id': questionDoc.id,
            ...questionData, // Include all fields from the question document
          };
        }).toList();

        return {
          'moduleTitle': moduleTitle,
          'questions': questions,
        };
      }).toList());

      return modules;
    } catch (e) {
      print('Error fetching modules: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Modules')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchChildData(),
        builder: (context, childDataSnapshot) {
          if (childDataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!childDataSnapshot.hasData || childDataSnapshot.data!.isEmpty) {
            return const Center(child: Text('Failed to load child data'));
          }

          final childData = childDataSnapshot.data!;
          final currentDifficulty = childData['current_difficulty'] ?? 'medium';

          return StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('subjects')
                .doc(subject)
                .collection('difficultyLevels')
                .doc(currentDifficulty.toLowerCase())
                .collection('questions')
                .snapshots(),
            builder: (context, questionSnapshot) {
              if (questionSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!questionSnapshot.hasData ||
                  questionSnapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No questions available'));
              }

              final questions = questionSnapshot.data!.docs;

              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionDetailScreen(
                          questions: questions
                              .map((doc) => doc.data() as Map<String, dynamic>)
                              .toList(),
                          childData: childData, // Pass childData here
                          currentSubject: subject,
                        ),
                      ),
                    );
                  },
                  child: const Text('Start Questions'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
