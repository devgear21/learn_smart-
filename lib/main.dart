import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnsmart/pages/accessibilty_settings_page.dart';
import 'package:provider/provider.dart'; // Import Provider for global state management
import 'package:learnsmart/pages/chat_screen.dart';
import 'package:learnsmart/pages/chatbot_screen.dart';
import 'package:learnsmart/home_page.dart';
import 'package:learnsmart/pages/avatar_screen.dart';
import 'package:learnsmart/pages/course_option.dart';
import 'package:learnsmart/pages/create_avatar.dart';
import 'package:learnsmart/pages/login.dart';
import 'package:learnsmart/pages/on_boarding_1.dart';
import 'package:learnsmart/pages/on_boarding_2.dart';
import 'package:learnsmart/pages/on_boarding_3.dart';
import 'package:learnsmart/pages/register.dart';
import 'package:learnsmart/pages/splash_screen.dart';
import 'package:learnsmart/pages/learning_modules_screen.dart';
import 'package:learnsmart/pages/user_info_screen.dart';
import 'package:learnsmart/pages/animation_screen.dart';
import 'accessibility_settings.dart'; // Accessibility settings provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AccessibilitySettings(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(
        context); // Access accessibility settings

    return MaterialApp(
      title: 'LearnSmart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: settings.fontSize,
            letterSpacing: 0.15,
            fontFamily:
                settings.dyslexiaFriendly ? 'OpenDyslexic' : 'DefaultFont',
          ),
          bodyMedium: TextStyle(
            fontSize: settings.fontSize - 2,
            letterSpacing: 0.15,
            fontFamily:
                settings.dyslexiaFriendly ? 'OpenDyslexic' : 'DefaultFont',
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: settings.highContrast ? Colors.yellow : Colors.blue,
          background: settings.highContrast ? Colors.black : Colors.white,
        ),
      ),
      initialRoute: '/splashscreen',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/onboarding1': (context) => const OnBoarding1(),
        '/onboarding2': (context) => const OnBoarding2(),
        '/onboarding3': (context) => const OnBoarding3(),
        '/homepage': (context) => const HomePage(),
        '/splashscreen': (context) => const SplashScreen(),
        '/courseoption': (context) => const CourseOption(),
        '/learning_modules': (context) => LearningModulesScreen(),
        '/avatar': (context) => const AvatarScreen(),
        '/animation': (context) => const AnimationScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/accessibility_settings': (context) =>
            const AccessibilitySettingsPage(),

        '/chatscreen': (context) =>
            const ChatScreen(), // No need to pass userId manually
        '/createAvatar': (context) => const CreateAvatar(),
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
        return null;
      },
    );
  }
}
