import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnsmart/pages/login.dart';
import 'package:learnsmart/pages/user_info_screen.dart';
import 'package:learnsmart/accessibility_settings.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        String userId = userCredential.user!.uid;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful!')),
        );

        // Navigate to the user info screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChildInfoPage(userId: userId),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        } else {
          message = 'Registration failed. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    return Scaffold(
      backgroundColor: settings.highContrast ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign up',
                style: TextStyle(
                  fontSize: settings.fontSize + 8,
                  fontWeight: FontWeight.bold,
                  fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                  color: settings.highContrast ? Colors.yellow : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Create an account, It's free",
                style: TextStyle(
                  fontSize: settings.fontSize - 2,
                  fontFamily: settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                  color:
                      settings.highContrast ? Colors.yellow : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        fontWeight: FontWeight.w500,
                        fontFamily:
                            settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        fontFamily:
                            settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black,
                      ),
                      decoration: InputDecoration(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final regex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        fontWeight: FontWeight.w500,
                        fontFamily:
                            settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        fontFamily:
                            settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black,
                      ),
                      decoration: InputDecoration(
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
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: settings.highContrast
                                ? Colors.yellow
                                : Colors.black54,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        fontWeight: FontWeight.w500,
                        fontFamily:
                            settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscurePassword,
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        fontFamily:
                            settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                        color: settings.highContrast
                            ? Colors.yellow
                            : Colors.black,
                      ),
                      decoration: InputDecoration(
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
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: settings.highContrast
                                ? Colors.yellow
                                : Colors.black54,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: settings.highContrast
                              ? Colors.yellow
                              : Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: settings.fontSize,
                            fontFamily: settings.dyslexiaFriendly
                                ? 'OpenDyslexic'
                                : null,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: settings.fontSize - 2,
                              fontFamily: settings.dyslexiaFriendly
                                  ? 'OpenDyslexic'
                                  : null,
                              color: settings.highContrast
                                  ? Colors.yellow
                                  : Colors.grey[700],
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                  fontSize: settings.fontSize - 2,
                                  fontFamily: settings.dyslexiaFriendly
                                      ? 'OpenDyslexic'
                                      : null,
                                  color: settings.highContrast
                                      ? Colors.yellow
                                      : Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
        backgroundColor:
            settings.highContrast ? Colors.yellow : Colors.blueAccent,
        child: Icon(
          Icons.settings_accessibility,
          color: settings.highContrast ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
