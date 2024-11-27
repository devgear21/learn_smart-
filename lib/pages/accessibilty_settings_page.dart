import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

class AccessibilitySettingsPage extends StatelessWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Font Size',
              style: TextStyle(fontSize: settings.fontSize),
            ),
            Slider(
              value: settings.fontSize,
              min: 12.0,
              max: 24.0,
              onChanged: (value) {
                settings.setFontSize(value);
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Dyslexia-Friendly Mode'),
              value: settings.dyslexiaFriendly,
              onChanged: (value) {
                settings.toggleDyslexiaFriendly();
              },
            ),
            SwitchListTile(
              title: const Text('High Contrast Mode'),
              value: settings.highContrast,
              onChanged: (value) {
                settings.toggleHighContrast();
              },
            ),
          ],
        ),
      ),
    );
  }
}
