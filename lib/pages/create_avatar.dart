import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

class CreateAvatar extends StatefulWidget {
  const CreateAvatar({super.key});

  @override
  _CreateAvatarState createState() => _CreateAvatarState();
}

class _CreateAvatarState extends State<CreateAvatar> {
  // ignore: unused_field
  final TextEditingController _promptController = TextEditingController();
  String? _avatarImage;
  bool _isLoading = false;

  String? selectedHair;
  String? selectedHairColor;
  String? selectedSkinTone;
  String? selectedGender;

  final List<String> hairStyles = [
    'Short',
    'Long',
    'Curly',
    'Straight',
    'Bald'
  ];
  final List<String> hairColors = ['Black', 'Blonde', 'Brown', 'Red', 'Gray'];
  final List<String> skinTones = ['Fair', 'Medium', 'Dark'];
  final List<String> genders = ['Male', 'Female', 'Non-binary'];

  Future<void> _generateAvatar() async {
    setState(() {
      _isLoading = true;
      _avatarImage = null;
    });

    String prompt =
        'A high-definition virtual assistant that is ${selectedGender ?? 'a person'} with ${selectedHair ?? 'any'} hair that is ${selectedHairColor ?? 'any color'} and has ${selectedSkinTone ?? 'any'} skin tone. The image should be clear, in ultra HD resolution, with distinct facial features and precise details to ensure easy lip sync.';

    try {
      var response = await http.post(
        Uri.parse('https://8fc2-34-87-3-145.ngrok-free.app/generate_image'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _avatarImage = responseBody['image'];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAvatar() async {
    if (_avatarImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Uint8List avatarBytes = base64Decode(_avatarImage!);

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not logged in';

      String userId = user.uid;
      String filePath = 'avatars/$userId.png';
      final storageRef = FirebaseStorage.instance.ref().child(filePath);

      await storageRef.putData(
          avatarBytes, SettableMetadata(contentType: 'image/png'));

      String downloadUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'imageUrl': downloadUrl,
      });

      Navigator.pushReplacementNamed(context, '/onboarding1');
    } catch (e) {
      print('Error saving avatar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving avatar: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generate Virtual Assistant Avatar',
          style: settings.dyslexiaFriendly
              ? TextStyle(
                  fontSize: settings.fontSize + 2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenDyslexic',
                  color: settings.highContrast ? Colors.yellow : Colors.white,
                )
              : TextStyle(
                  fontSize: settings.fontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: settings.highContrast ? Colors.yellow : Colors.white,
                ),
        ),
        backgroundColor: settings.highContrast ? Colors.black : Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildDropdownCard(
              title: "Select Gender",
              value: selectedGender,
              items: genders,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
              settings: settings,
            ),
            const SizedBox(height: 20),
            _buildDropdownCard(
              title: "Select Hair Style",
              value: selectedHair,
              items: hairStyles,
              onChanged: (value) {
                setState(() {
                  selectedHair = value;
                });
              },
              settings: settings,
            ),
            const SizedBox(height: 20),
            _buildDropdownCard(
              title: "Select Hair Color",
              value: selectedHairColor,
              items: hairColors,
              onChanged: (value) {
                setState(() {
                  selectedHairColor = value;
                });
              },
              settings: settings,
            ),
            const SizedBox(height: 20),
            _buildDropdownCard(
              title: "Select Skin Tone",
              value: selectedSkinTone,
              items: skinTones,
              onChanged: (value) {
                setState(() {
                  selectedSkinTone = value;
                });
              },
              settings: settings,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _generateAvatar,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    settings.highContrast ? Colors.black : Colors.blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Generate Avatar',
                style: TextStyle(
                  fontSize: settings.fontSize,
                  fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                  color: settings.highContrast ? Colors.yellow : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _avatarImage != null
                    ? Column(
                        children: [
                          Text(
                            'Generated Avatar:',
                            style: TextStyle(
                              fontSize: settings.fontSize,
                              fontWeight: FontWeight.bold,
                              color: settings.highContrast
                                  ? Colors.yellow
                                  : Colors.black54,
                              fontFamily: settings.dyslexiaFriendly
                                  ? 'OpenDyslexic'
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.memory(
                            base64Decode(_avatarImage!),
                            height: 300,
                            width: 300,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _saveAvatar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: settings.highContrast
                                  ? Colors.black
                                  : Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Save Avatar',
                              style: TextStyle(
                                fontSize: settings.fontSize,
                                fontFamily: settings.dyslexiaFriendly
                                    ? 'OpenDyslexic'
                                    : null,
                                color: settings.highContrast
                                    ? Colors.yellow
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Select options to generate an avatar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: settings.fontSize,
                          fontFamily:
                              settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black54,
                        ),
                      ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/accessibility_settings');
        },
        backgroundColor: settings.highContrast ? Colors.yellow : Colors.blue,
        child: const Icon(Icons.settings_accessibility, color: Colors.white),
      ),
    );
  }

  Widget _buildDropdownCard({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required AccessibilitySettings settings,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: settings.fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                color: settings.highContrast ? Colors.yellow : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: value,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor:
                    settings.highContrast ? Colors.black : Colors.grey[200],
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: settings.fontSize,
                      fontFamily:
                          settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
