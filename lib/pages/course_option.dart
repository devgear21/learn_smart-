import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseOption extends StatefulWidget {
  const CourseOption({super.key});

  @override
  _CourseOptionState createState() => _CourseOptionState();
}

class _CourseOptionState extends State<CourseOption> {
  String? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 33, 150, 243),
              Color.fromARGB(255, 2, 50, 100),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Header
                Text(
                  'Select a Lesson',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // Course Options
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CourseOptionItem(
                        title: 'English',
                        isSelected: selectedCourse == 'English',
                        onTap: () {
                          setState(() {
                            selectedCourse = 'English';
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CourseOptionItem(
                        title: 'Mathematics',
                        isSelected: selectedCourse == 'Mathematics',
                        onTap: () {
                          setState(() {
                            selectedCourse = 'Mathematics';
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CourseOptionItem(
                        title: 'General Knowledge',
                        isSelected: selectedCourse == 'General Knowledge',
                        onTap: () {
                          setState(() {
                            selectedCourse = 'General Knowledge';
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Get Started Button
                GestureDetector(
                  onTap: () {
                    if (selectedCourse != null) {
                      Navigator.pushNamed(context, '/learning_modules');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 33, 150, 243),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseOptionItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const CourseOptionItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Colors.white.withOpacity(0.85)
              : Colors.white.withOpacity(0.15),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? const Color.fromARGB(255, 33, 150, 243)
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
