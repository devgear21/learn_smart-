import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:learnsmart/pages/course_option.dart';
import 'package:learnsmart/pages/login.dart';
import 'package:learnsmart/pages/on_boarding_1.dart';
import 'package:learnsmart/pages/on_boarding_2.dart';
import 'package:learnsmart/pages/on_boarding_3.dart';
import 'package:learnsmart/pages/register.dart';
import 'package:learnsmart/pages/splash_screen.dart';
import 'package:learnsmart/pages/learning_modules_screen.dart';
import 'package:learnsmart/pages/user_info_screen.dart';
// Import the ChildInfoPage

// Import your firebase options file if used
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnSmart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splashscreen', // Set the initial route
      routes: {
        '/login': (context) => const Login(), // Define the Login page route
        '/register': (context) =>
            const Register(), // Define the Register page route
        '/onboarding1': (context) => const OnBoarding1(),
        '/onboarding2': (context) => const OnBoarding2(),
        '/onboarding3': (context) => const OnBoarding3(),
        '/splashscreen': (context) => const SplashScreen(),
        '/courseoption': (context) => const CourseOption(),
        '/learning_modules': (context) => LearningModulesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/child_info') {
          final String userId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return ChildInfoPage(userId: userId);
            },
          );
        }
        // Handle other routes here if needed
        return null; // If no match, return null
      },
    );
  }
}
