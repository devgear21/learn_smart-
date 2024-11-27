import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

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
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _saveInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Save information to Firestore
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
      });

      setState(() {
        _isLoading = false;
      });

      // Navigate to create_avatar.dart page after saving
      Navigator.pushReplacementNamed(context, '/createAvatar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Child Information",
          style: settings.dyslexiaFriendly
              ? TextStyle(
                  fontSize: settings.fontSize + 4,
                  fontWeight: FontWeight.w600,
                  color: settings.highContrast ? Colors.yellow : Colors.white,
                  fontFamily: 'OpenDyslexic',
                )
              : GoogleFonts.poppins(
                  fontSize: settings.fontSize + 4,
                  fontWeight: FontWeight.w600,
                  color: settings.highContrast ? Colors.yellow : Colors.white,
                ),
        ),
        backgroundColor: settings.highContrast ? Colors.black : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title
              Text(
                'Enter Your Child’s Details',
                style: settings.dyslexiaFriendly
                    ? TextStyle(
                        fontSize: settings.fontSize + 6,
                        fontWeight: FontWeight.bold,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black87,
                        fontFamily: 'OpenDyslexic',
                      )
                    : GoogleFonts.poppins(
                        fontSize: settings.fontSize + 6,
                        fontWeight: FontWeight.bold,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black87,
                      ),
              ),
              const SizedBox(height: 30),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: settings.dyslexiaFriendly
                      ? TextStyle(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                          fontFamily: 'OpenDyslexic',
                        )
                      : GoogleFonts.poppins(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.grey[400]!,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: settings.fontSize,
                  fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                  color: settings.highContrast ? Colors.yellow : Colors.black87,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Age Field
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: settings.dyslexiaFriendly
                      ? TextStyle(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                          fontFamily: 'OpenDyslexic',
                        )
                      : GoogleFonts.poppins(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.grey[400]!,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: settings.fontSize,
                  fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                  color: settings.highContrast ? Colors.yellow : Colors.black87,
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

              // Learning Preference Dropdown
              DropdownButtonFormField<String>(
                value: _learningPreference,
                decoration: InputDecoration(
                  labelText: "Learning Preference",
                  labelStyle: settings.dyslexiaFriendly
                      ? TextStyle(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                          fontFamily: 'OpenDyslexic',
                        )
                      : GoogleFonts.poppins(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.grey[400]!,
                    ),
                  ),
                ),
                items: ['Visual', 'Auditory', 'Kinesthetic']
                    .map((preference) => DropdownMenuItem(
                          value: preference,
                          child: Text(
                            preference,
                            style: TextStyle(
                              fontSize: settings.fontSize,
                              fontFamily: settings.dyslexiaFriendly
                                  ? 'OpenDyslexic'
                                  : null,
                              color: settings.highContrast
                                  ? Colors.yellow
                                  : Colors.black87,
                            ),
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

              // Checkbox: Dyslexia
              CheckboxListTile(
                title: Text(
                  'Dyslexia',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontFamily:
                        settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                    color:
                        settings.highContrast ? Colors.yellow : Colors.black87,
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

              // Checkbox: ASD
              CheckboxListTile(
                title: Text(
                  'ASD (Autism Spectrum Disorder)',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontFamily:
                        settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                    color:
                        settings.highContrast ? Colors.yellow : Colors.black87,
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

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Set Parental Lock Password",
                  labelStyle: settings.dyslexiaFriendly
                      ? TextStyle(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                          fontFamily: 'OpenDyslexic',
                        )
                      : GoogleFonts.poppins(
                          fontSize: settings.fontSize,
                          fontWeight: FontWeight.w500,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.black87,
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.grey[400]!,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color:
                          settings.highContrast ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontSize: settings.fontSize,
                  fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                  color: settings.highContrast ? Colors.yellow : Colors.black87,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please set a parental lock password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      settings.highContrast ? Colors.black : Colors.blue,
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
                        style: TextStyle(
                          fontSize: settings.fontSize,
                          fontFamily:
                              settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
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
}
