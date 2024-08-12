import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lessons_screen.dart';

class LearningModulesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Learning Modules')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('modules').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final modules = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(module['title']),
                subtitle: Text(module['description']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LessonsScreen(module: modules[index]),
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
