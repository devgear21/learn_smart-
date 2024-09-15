import 'package:flutter/material.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen>
    with TickerProviderStateMixin {
  late AnimationController _eyeBlinkController;
  late AnimationController _smileController;
  late AnimationController _handMovementController;
  late AnimationController _lipsMovementController;

  late Animation<double> _eyeBlinkAnimation;
  late Animation<double> _smileAnimation;
  late Animation<double> _handMovementAnimation;
  late Animation<double> _lipsMovementAnimation;

  @override
  void initState() {
    super.initState();

    // Eye Blinking Animation
    _eyeBlinkController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _eyeBlinkAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_eyeBlinkController);

    // Smile Animation
    _smileController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _smileAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_smileController);

    // Hand Movement Animation
    _handMovementController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _handMovementAnimation =
        Tween<double>(begin: 0.0, end: 20.0).animate(_handMovementController);

    // Lips Movement Animation
    _lipsMovementController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _lipsMovementAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(_lipsMovementController);

    // Start animations
    startAnimations();
  }

  void startAnimations() {
    _eyeBlinkController.forward().then((_) {
      _eyeBlinkController.reverse();
      _smileController.forward().then((_) {
        _handMovementController.repeat(reverse: true);
        _lipsMovementController.repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    _eyeBlinkController.dispose();
    _smileController.dispose();
    _handMovementController.dispose();
    _lipsMovementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatar Animation')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 100,
              child: AnimatedBuilder(
                animation: _handMovementAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -_handMovementAnimation.value),
                    child: Image.asset('assets/images/hand.png', height: 100),
                  );
                },
              ),
            ),
            Image.asset('assets/images/avatar_base.png', height: 200),
            Positioned(
              top: 60,
              child: AnimatedBuilder(
                animation: _eyeBlinkAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _eyeBlinkAnimation.value,
                    child:
                        Image.asset('assets/images/eyes_open.png', height: 50),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 60,
              child: AnimatedBuilder(
                animation: _smileAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _smileAnimation.value,
                    child: Image.asset('assets/images/smile.png', height: 50),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 40,
              child: AnimatedBuilder(
                animation: _lipsMovementAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _lipsMovementAnimation.value),
                    child: Image.asset('assets/images/lips.png', height: 30),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
