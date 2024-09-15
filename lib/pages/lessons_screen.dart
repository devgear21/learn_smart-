import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lesson_content_screen.dart';

class LessonsScreen extends StatelessWidget {
  final String moduleId;

  LessonsScreen({super.key, required this.moduleId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('modules')
            .doc(moduleId)
            .collection('lessons')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No lessons available'));
          }

          final lessons = snapshot.data!.docs;

          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lessonData = lessons[index].data() as Map<String, dynamic>?;
              final lessonId = lessons[index].id;

              // Check if lessonData is null
              if (lessonData == null) {
                print('Lesson data is null for lessonId: $lessonId');
                return const ListTile(
                  title: Text('Unknown Lesson'),
                  subtitle: Text('Data not available'),
                );
              }

              final lessonTitle = lessonData['title'] ?? 'Untitled Lesson';
              final lessonDescription =
                  lessonData['description'] ?? 'No description available';

              print(
                  'Lesson ID: $lessonId, Title: $lessonTitle, Description: $lessonDescription');

              return ListTile(
                title: Text(lessonTitle),
                subtitle: Text(lessonDescription),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonContentScreen(
                        lessonId: lessonId,
                        moduleId: moduleId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
