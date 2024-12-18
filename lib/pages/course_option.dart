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
                        title: 'Math',
                        isSelected: selectedCourse == 'Math',
                        onTap: () {
                          setState(() {
                            selectedCourse = 'Math';
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CourseOptionItem(
                        title: 'General Education',
                        isSelected: selectedCourse == 'General Education',
                        onTap: () {
                          setState(() {
                            selectedCourse = 'General Education';
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
                      Navigator.pushNamed(context, '/learning_modules',
                          arguments: selectedCourse);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a course first!'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 2, 50, 100),
                        ),
                      ),
                    ),
                  ),
                ),
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
  final bool isSelected;
  final VoidCallback onTap;

  const CourseOptionItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.grey.shade300,
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isSelected
                ? const Color.fromARGB(255, 33, 150, 243)
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
