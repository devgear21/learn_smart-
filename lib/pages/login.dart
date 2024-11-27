import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnsmart/home_page.dart';
import 'package:learnsmart/pages/register.dart';
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _forgotPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter your email to reset the password.')),
      );
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password reset email sent successfully.')),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found with this email.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User does not exist.')),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong password provided.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    return Scaffold(
      backgroundColor: settings.highContrast ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-width image
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/login_illustration.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: settings.fontSize + 8,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.black87, // Yellow for high contrast
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: settings.fontSize - 2,
                      fontFamily:
                          settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                      color: settings.highContrast
                          ? Colors.yellow
                          : Colors.black54, // Yellow for high contrast
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(
                            fontSize: settings.fontSize - 2,
                            fontFamily: settings.dyslexiaFriendly
                                ? 'OpenDyslexic'
                                : null,
                            color: settings.highContrast
                                ? Colors.yellow
                                : Colors.black, // Dynamic text color
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: settings.fontSize - 2,
                              fontFamily: settings.dyslexiaFriendly
                                  ? 'OpenDyslexic'
                                  : null,
                              color: settings.highContrast
                                  ? Colors.yellow
                                  : Colors.black54, // Dynamic label color
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: settings.highContrast
                                    ? Colors.yellow
                                    : Colors.blueAccent, // Dynamic border color
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),

// Password field
                        TextFormField(
                          controller: _passwordController,
                          style: TextStyle(
                            fontSize: settings.fontSize - 2,
                            fontFamily: settings.dyslexiaFriendly
                                ? 'OpenDyslexic'
                                : null,
                            color: settings.highContrast
                                ? Colors.yellow
                                : Colors.black, // Dynamic text color
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: settings.fontSize - 2,
                              fontFamily: settings.dyslexiaFriendly
                                  ? 'OpenDyslexic'
                                  : null,
                              color: settings.highContrast
                                  ? Colors.yellow
                                  : Colors.black54, // Dynamic label color
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: settings.highContrast
                                    ? Colors.yellow
                                    : Colors.blueAccent, // Dynamic border color
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: settings.highContrast
                                    ? Colors.yellow
                                    : Colors.black54, // Dynamic icon color
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _forgotPassword,
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: settings.fontSize - 2,
                                fontFamily: settings.dyslexiaFriendly
                                    ? 'OpenDyslexic'
                                    : null,
                                color: settings.highContrast
                                    ? Colors.yellow
                                    : Colors
                                        .blueAccent, // Yellow for high contrast
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Login',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: _register,
                      child: Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          fontSize: settings.fontSize - 2,
                          fontFamily:
                              settings.dyslexiaFriendly ? 'OpenDyslexic' : null,
                          color: settings.highContrast
                              ? Colors.yellow
                              : Colors.blueAccent, // Yellow for high contrast
                          fontWeight: FontWeight.w500,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/accessibility_settings');
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.settings_accessibility),
      ),
    );
  }
}
