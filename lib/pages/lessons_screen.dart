import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lesson_content_screen.dart';

class LessonsScreen extends StatelessWidget {
  final String moduleId;

  LessonsScreen({required this.moduleId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lessons')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('modules')
            .doc(moduleId)
            .collection('lessons')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No lessons available'));
          }

          final lessons = snapshot.data!.docs;

          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index].data() as Map<String, dynamic>;
              final lessonId = lessons[index].id;

              return ListTile(
                title: Text(lesson['title']),
                subtitle: Text(lesson['description']),
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
