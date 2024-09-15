import 'dart:async';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  // States for lips and eyes
  bool isBlinking = false;
  bool isTalking = false;
  bool isSmiling = false;

  late Timer _eyeTimer;
  late Timer _lipTimer;

  @override
  void initState() {
    super.initState();

    // Set up blinking animation
    _eyeTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        isBlinking = true;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          isBlinking = false;
        });
      });
    });

    // Set up lip movement (talking/smiling) animation
    _lipTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        isTalking = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isTalking = false;
          isSmiling = true;
        });
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isSmiling = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _eyeTimer.cancel();
    _lipTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Animation'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Base image of the person
            Image.asset('assets/images/avatar_base.png'),

            // Eyes: switch between open and blinking
            Positioned(
              top: 50,
              child: Image.asset(
                isBlinking ? 'assets/eyes_blink.png' : 'assets/eyes_open.png',
                width: 100,
                height: 50,
              ),
            ),

            // Lips: switch between normal, talking, and smiling
            Positioned(
              bottom: 50,
              child: Image.asset(
                isTalking
                    ? 'assets/lips_talk.png'
                    : (isSmiling
                        ? 'assets/lips_smile.png'
                        : 'assets/lips_normal.png'),
                width: 100,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
