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

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No modules available'));
          }

          final modules = snapshot.data!.docs;

          return ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final moduleData = modules[index].data() as Map<String, dynamic>;
              final moduleId = modules[index].id;
              final moduleTitle = moduleData['title'] ??
                  'Untitled Module'; // Provide a default value
              final moduleDescription = moduleData['description'] ??
                  'No description available'; // Provide a default value

              // Debugging output to check the module data
              print(
                  'Module ID: $moduleId, Title: $moduleTitle, Description: $moduleDescription');

              return ListTile(
                title: Text(moduleTitle),
                subtitle: Text(moduleDescription),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonsScreen(moduleId: moduleId),
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
