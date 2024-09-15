import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_screen.dart';

class LessonContentScreen extends StatelessWidget {
  final String moduleId;
  final String lessonId;

  LessonContentScreen(
      {super.key, required this.moduleId, required this.lessonId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson Content')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('modules')
            .doc(moduleId)
            .collection('lessons')
            .doc(lessonId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No content available'));
          }

          final lessonData = snapshot.data!.data() as Map<String, dynamic>?;

          // Check if lessonData is null
          if (lessonData == null) {
            print('Lesson content data is null for lessonId: $lessonId');
            return const Center(child: Text('No lesson data found'));
          }

          final content = lessonData['content'] as List<dynamic>? ?? [];
          final quiz = lessonData['quiz'] as Map<String, dynamic>?;

          return ListView.builder(
            itemCount: content.length + (quiz != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < content.length) {
                final item = content[index] as Map<String, dynamic>?;

                // Check if item is null
                if (item == null) {
                  print('Content item is null at index: $index');
                  return const ListTile(
                    title: Text('Unknown Content'),
                    subtitle: Text('Data not available'),
                  );
                }

                if (item['type'] == 'audio') {
                  return ListTile(
                    title: Text(item['description'] ?? 'No description'),
                    trailing: const Icon(Icons.audiotrack),
                    onTap: () {
                      // Play audio logic
                    },
                  );
                } else if (item['type'] == 'image') {
                  return Column(
                    children: [
                      Image.network(item['url'] ?? ''),
                      Text(item['description'] ?? 'No description'),
                    ],
                  );
                } else if (item['type'] == 'text') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item['content'] ?? ''),
                  );
                }
              } else if (quiz != null) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(quiz: quiz),
                      ),
                    );
                  },
                  child: const Text('Take Quiz'),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
