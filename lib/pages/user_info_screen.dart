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
  String? _currentDifficulty;
  bool _dyslexia = false;
  bool _asd = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _saveInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final now = DateTime.now();

        // Prepare child_data structure
        final childData = {
          "age": int.parse(_ageController.text.trim()),
          "learning_challenge":
              _asd ? "Autism" : (_dyslexia ? "Dyslexia" : "None"),
          "transition_history": [0, 1, 2, 1, 0], // Initial difficulty history
          "current_difficulty":
              _currentDifficulty ?? "Medium", // Default difficulty
        };

        // Prepare quiz_data structures
        final quizDataEnglish = {
          "total_questions_attempted": 0,
          "correct_answers": 0,
          "accuracy": 0.0,
          "avg_attempt_time": 0.0,
          "train": true,
        };

        final quizDataMath = {
          "total_questions_attempted": 0,
          "correct_answers": 0,
          "accuracy": 0.0,
          "avg_attempt_time": 0.0,
          "train": true,
        };

        final quizDataGeneralKnowledge = {
          "total_questions_attempted": 0,
          "correct_answers": 0,
          "accuracy": 0.0,
          "avg_attempt_time": 0.0,
          "train": true,
        };

        // Save data to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .set({
          "name": _nameController.text.trim(),
          "child_data": childData,
          "quiz_data_english": quizDataEnglish,
          "quiz_data_math": quizDataMath,
          "quiz_data_general_knowledge": quizDataGeneralKnowledge,
          "parentalLockPassword": _passwordController.text.trim(),
          "createdAt": now.toIso8601String(),
          "updatedAt": now.toIso8601String(),
        });

        // Navigate to the next page
        Navigator.pushReplacementNamed(context, '/createAvatar');
      } catch (e) {
        print("Error saving information: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to save information. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_accessibility, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/accessibility_settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
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
              ),
              const SizedBox(height: 30),

              _buildTextField(
                label: "Name",
                controller: _nameController,
                settings: settings,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: "Age",
                controller: _ageController,
                settings: settings,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Current Difficulty Dropdown
              DropdownButtonFormField<String>(
                value: _currentDifficulty,
                decoration: _inputDecoration("Current Difficulty", settings),
                items: ['Easy', 'Medium', 'Hard']
                    .map((difficulty) => DropdownMenuItem(
                          value: difficulty,
                          child: Text(
                            difficulty,
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
                    _currentDifficulty = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a difficulty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildCheckbox(
                label: "Dyslexia",
                value: _dyslexia,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _dyslexia = true;
                      _asd = false;
                    } else {
                      _dyslexia = false;
                    }
                  });
                },
                settings: settings,
              ),
              const SizedBox(height: 10),

              _buildCheckbox(
                label: "ASD (Autism Spectrum Disorder)",
                value: _asd,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _asd = true;
                      _dyslexia = false;
                    } else {
                      _asd = false;
                    }
                  });
                },
                settings: settings,
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: "Set Parental Lock Password",
                controller: _passwordController,
                settings: settings,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: settings.highContrast ? Colors.yellow : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please set a parental lock password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        settings.highContrast ? Colors.black : Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Save Information',
                          style: TextStyle(
                            fontSize: settings.fontSize,
                            fontFamily: settings.dyslexiaFriendly
                                ? 'OpenDyslexic'
                                : null,
                            color: settings.highContrast
                                ? Colors.yellow
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required AccessibilitySettings settings,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration:
          _inputDecoration(label, settings).copyWith(suffixIcon: suffixIcon),
      validator: validator,
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required void Function(bool?) onChanged,
    required AccessibilitySettings settings,
  }) {
    return CheckboxListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: settings.fontSize,
          fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
          color: settings.highContrast ? Colors.yellow : Colors.black87,
        ),
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  InputDecoration _inputDecoration(
      String label, AccessibilitySettings settings) {
    return InputDecoration(
      labelText: label,
      labelStyle: settings.dyslexiaFriendly
          ? TextStyle(
              fontSize: settings.fontSize,
              fontWeight: FontWeight.w500,
              color: settings.highContrast ? Colors.yellow : Colors.black87,
              fontFamily: 'OpenDyslexic',
            )
          : GoogleFonts.poppins(
              fontSize: settings.fontSize,
              fontWeight: FontWeight.w500,
              color: settings.highContrast ? Colors.yellow : Colors.black87,
            ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: settings.highContrast ? Colors.yellow : Colors.grey[400]!,
        ),
      ),
    );
  }
}
