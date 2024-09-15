import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChildInfoPage extends StatefulWidget {
  final String userId;

  const ChildInfoPage({super.key, required this.userId});

  @override
  _ChildInfoPageState createState() => _ChildInfoPageState();
}

class _ChildInfoPageState extends State<ChildInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _learningPreference;
  bool _dyslexia = false;
  bool _asd = false;
  File? _image;
  bool _isLoading = false;

  Future<void> _saveInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String? imageUrl;

      // Upload image to Firebase Storage if an image is selected
      if (_image != null) {
        try {
          final storageRef = FirebaseStorage.instance.ref().child(
              'child_images/${widget.userId}/${DateTime.now().millisecondsSinceEpoch}.jpg');

          final uploadTask = storageRef.putFile(_image!);
          final snapshot = await uploadTask.whenComplete(() => null);
          imageUrl = await snapshot.ref.getDownloadURL();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image upload failed: $e')),
          );
        }
      }

      // Save information to Firestore, including image URL if available
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .set({
        'name': _nameController.text,
        'age': _ageController.text,
        'learningPreference': _learningPreference,
        'dyslexia': _dyslexia,
        'asd': _asd,
        'parentalLockPassword': _passwordController.text,
        'imageUrl': imageUrl, // Save the image URL
        'onboardingComplete': false,
      });

      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacementNamed(context, '/onboarding1');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Camera permission is required to take a photo')),
        );
        return;
      }
    }

    if (source == ImageSource.gallery) {
      final status = await Permission.photos.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Gallery permission is required to select a photo')),
        );
        return;
      }
    }

    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Child Information",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Enter Your Child’s Details',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _image == null
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text('Camera'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text('Camera'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _learningPreference,
                decoration: InputDecoration(
                  labelText: "Learning Preference",
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                items: ['Visual', 'Auditory', 'Kinesthetic']
                    .map((preference) => DropdownMenuItem(
                          value: preference,
                          child: Text(
                            preference,
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _learningPreference = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a learning preference';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Set Parental Lock Password",
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please set a parental lock password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: Text(
                  'Dyslexia',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _dyslexia,
                onChanged: (value) {
                  setState(() {
                    _dyslexia = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: Text(
                  'ASD (Autism Spectrum Disorder)',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _asd,
                onChanged: (value) {
                  setState(() {
                    _asd = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveInfo,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Save Information',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
