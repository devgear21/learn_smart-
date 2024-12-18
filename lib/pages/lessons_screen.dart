import 'package:flutter/material.dart';
import 'package:learnsmart/pages/accessibilty_settings_page.dart';
import 'package:provider/provider.dart';
import '../accessibility_settings.dart';

class LessonsScreen extends StatelessWidget {
  final String subjectId;
  final List<Map<String, dynamic>> modules;

  LessonsScreen({super.key, required this.subjectId, required this.modules});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    // Accessibility settings
    final fontFamily = settings.dyslexiaFriendly ? 'OpenDyslexic' : 'Poppins';
    final textColor = settings.highContrast ? Colors.yellow : Colors.black;
    final backgroundColor = settings.highContrast ? Colors.black : Colors.white;
    final tileBackgroundColor =
        settings.highContrast ? Colors.grey[800] : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Lessons for $subjectId',
          style: TextStyle(
            fontFamily: fontFamily,
            color: textColor,
            fontSize: settings.fontSize + 2,
          ),
        ),
        backgroundColor:
            settings.highContrast ? Colors.black : const Color(0xFF2196F3),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_accessibility,
              color: settings.highContrast ? Colors.yellow : Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccessibilitySettingsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          final moduleTitle = module['moduleTitle'];
          final questions = module['questions'] as List<Map<String, dynamic>>;

          return Card(
            elevation: 4,
            color: tileBackgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ExpansionTile(
              title: Text(
                moduleTitle,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: settings.fontSize,
                  color: textColor,
                ),
              ),
              children: questions.map((question) {
                return ListTile(
                  title: Text(
                    question['questionText'] ?? 'Question',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: settings.fontSize - 2,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    'ID: ${question['id']}',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: settings.fontSize - 4,
                      color: textColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
