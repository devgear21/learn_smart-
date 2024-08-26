import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          color: Color(0xFFFDFDFD),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              decoration: const BoxDecoration(
                color: Color(0xFF4C6ED7),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(187.5),
                  bottomLeft: Radius.circular(187.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.1, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '9:41',
                            style: GoogleFonts.getFont(
                              'Roboto Condensed',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              height: 1.3,
                              letterSpacing: -0.2,
                              color: const Color(0xFF000000),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/vectors/cellular_connection_8_x2.svg',
                                width: 17,
                                height: 10.7,
                              ),
                              const SizedBox(width: 5),
                              SvgPicture.asset(
                                'assets/vectors/wifi_17_x2.svg',
                                width: 15.3,
                                height: 11,
                              ),
                              const SizedBox(width: 5),
                              SvgPicture.asset(
                                'assets/vectors/battery_x2.svg',
                                width: 24.3,
                                height: 11.3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Choose The Lesson You Want',
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            height: 1.4,
                            color: const Color(0xFFFDFDFD),
                          ),
                          children: [
                            TextSpan(
                              text: ' to',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                height: 1.3,
                                color: const Color(0xFFFDFDFD),
                              ),
                            ),
                            TextSpan(
                              text: ' Learn',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                height: 1.4,
                                color: const Color(0xFFFDFDFD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CourseOptionItem(
                    title: 'English',
                    borderColor: const Color(0xFF4C6ED7),
                    textColor: const Color(0xFF4C6ED7),
                    onTap: () {
                      setState(() {
                        selectedCourse = 'English';
                      });
                    },
                    isSelected: selectedCourse == 'English',
                  ),
                  const SizedBox(height: 25),
                  CourseOptionItem(
                    title: 'Mathematics',
                    borderColor: const Color(0xFF4C6ED7),
                    textColor: const Color(0xFF4C6ED7),
                    onTap: () {
                      setState(() {
                        selectedCourse = 'Mathematics';
                      });
                    },
                    isSelected: selectedCourse == 'Mathematics',
                  ),
                  const SizedBox(height: 25),
                  CourseOptionItem(
                    title: 'General Knowledge',
                    borderColor: const Color(0xFF4C6ED7),
                    textColor: const Color(0xFF4C6ED7),
                    onTap: () {
                      setState(() {
                        selectedCourse = 'General Knowledge';
                      });
                    },
                    isSelected: selectedCourse == 'General Knowledge',
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  if (selectedCourse == 'English') {
                    Navigator.pushNamed(context, '/learning_modules');
                  } else {
                    // You can handle other cases or show a message
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C6ED7),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        height: 1.6,
                        color: const Color(0xFFFDFDFD),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF181818),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseOptionItem extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool isSelected;

  const CourseOptionItem({
    super.key,
    required this.title,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color:
                  isSelected ? Color.fromARGB(255, 18, 0, 118) : borderColor),
          borderRadius: BorderRadius.circular(6),
          color: isSelected
              ? Color.fromARGB(255, 18, 0, 118).withOpacity(0.2)
              : const Color(0xFFFDFDFD),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              height: 1.6,
              color: isSelected ? Color.fromARGB(255, 0, 6, 129) : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
