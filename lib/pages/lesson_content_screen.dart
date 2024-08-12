import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_screen.dart';

class LessonContentScreen extends StatelessWidget {
  final String lessonId;
  final String moduleId;

  LessonContentScreen({required this.lessonId, required this.moduleId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lesson Content')),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore
            .collection('modules')
            .doc(moduleId)
            .collection('lessons')
            .doc(lessonId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Lesson not found'));
          }

          final lesson = snapshot.data!.data() as Map<String, dynamic>;
          final content = lesson['content'] as List<dynamic>;
          final quiz = lesson['quiz'] as Map<String, dynamic>?;

          return ListView.builder(
            itemCount: content.length + (quiz != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < content.length) {
                final item = content[index] as Map<String, dynamic>;
                if (item['type'] == 'audio') {
                  return ListTile(
                    title: Text(item['description']),
                    trailing: Icon(Icons.audiotrack),
                    onTap: () {
                      // Play audio logic
                    },
                  );
                } else if (item['type'] == 'image') {
                  return Column(
                    children: [
                      Image.network(item['url']),
                      Text(item['description']),
                    ],
                  );
                } else if (item['type'] == 'text') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item['content']),
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
                  child: Text('Take Quiz'),
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
