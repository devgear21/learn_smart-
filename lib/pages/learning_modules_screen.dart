import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lessons_screen.dart';

class LearningModulesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LearningModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Modules')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('modules').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No modules available'));
          }

          final modules = snapshot.data!.docs;

          return ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final moduleData = modules[index].data() as Map<String, dynamic>?;
              final moduleId = modules[index].id;

              // Check if moduleData is null
              if (moduleData == null) {
                print('Module data is null for moduleId: $moduleId');
                return const ListTile(
                  title: Text('Unknown Module'),
                  subtitle: Text('Data not available'),
                );
              }

              final moduleTitle = moduleData['title'] ?? 'Untitled Module';
              final moduleDescription =
                  moduleData['description'] ?? 'No description available';

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
