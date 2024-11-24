import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAvatar extends StatefulWidget {
  const CreateAvatar({Key? key}) : super(key: key);

  @override
  _CreateAvatarState createState() => _CreateAvatarState();
}

class _CreateAvatarState extends State<CreateAvatar> {
  // ignore: unused_field
  final TextEditingController _promptController = TextEditingController();
  String? _avatarImage; // To hold the base64 image string
  bool _isLoading = false; // To show loading state

  // Dropdown values
  String? selectedHair;
  String? selectedHairColor;
  String? selectedSkinTone;
  String? selectedGender;

  // Dropdown options
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

  // Function to send the prompt and get avatar
  Future<void> _generateAvatar() async {
    setState(() {
      _isLoading = true;
      _avatarImage = null;
    });

    // Create the prompt by combining selected options, ensuring the avatar looks like a virtual assistant
    String prompt =
        'A high-definition virtual assistant that is ${selectedGender ?? 'a person'} with ${selectedHair ?? 'any'} hair that is ${selectedHairColor ?? 'any color'} and has ${selectedSkinTone ?? 'any'} skin tone. The image should be clear, in ultra HD resolution, with distinct facial features and precise details to ensure easy lip sync.';

    try {
      var response = await http.post(
        Uri.parse('https://3d59-35-204-27-155.ngrok-free.app/generate_image'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _avatarImage = responseBody['image']; // Set the base64 image string
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

  // Function to save avatar to Firebase Storage and update Firestore
  Future<void> _saveAvatar() async {
    if (_avatarImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Convert base64 string back to bytes
      Uint8List avatarBytes = base64Decode(_avatarImage!);

      // Get the current user's UID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not logged in';
      }
      String userId = user.uid;

      // Save the image to Firebase Storage
      String filePath = 'avatars/$userId.png';
      final storageRef = FirebaseStorage.instance.ref().child(filePath);
      await storageRef.putData(
          avatarBytes, SettableMetadata(contentType: 'image/png'));

      // Get the download URL
      String downloadUrl = await storageRef.getDownloadURL();

      // Update the user's Firestore document with the image URL
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'imageUrl': downloadUrl,
      });

      // Navigate to onboarding1.dart page
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Virtual Assistant Avatar'),
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Gender selection card
            _buildDropdownCard(
              title: "Select Gender",
              value: selectedGender,
              items: genders,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Hair style selection card
            _buildDropdownCard(
              title: "Select Hair Style",
              value: selectedHair,
              items: hairStyles,
              onChanged: (value) {
                setState(() {
                  selectedHair = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Hair color selection card
            _buildDropdownCard(
              title: "Select Hair Color",
              value: selectedHairColor,
              items: hairColors,
              onChanged: (value) {
                setState(() {
                  selectedHairColor = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Skin tone selection card
            _buildDropdownCard(
              title: "Select Skin Tone",
              value: selectedSkinTone,
              items: skinTones,
              onChanged: (value) {
                setState(() {
                  selectedSkinTone = value;
                });
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                _generateAvatar(); // Generate avatar based on selected options
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 33, 150, 243),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Generate Avatar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Display the generated avatar image or loading indicator
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _avatarImage != null
                    ? Column(
                        children: [
                          const Text(
                            'Generated Avatar:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
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
                            onPressed:
                                _saveAvatar, // Save the avatar to Firebase
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 33, 150, 243),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Save Avatar',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          'Select options to generate an avatar',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build dropdown card for the options
  Widget _buildDropdownCard({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
                fillColor: Colors.grey[200],
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
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
