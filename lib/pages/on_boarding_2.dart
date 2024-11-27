import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnsmart/pages/accessibilty_settings_page.dart';
import 'package:learnsmart/pages/on_boarding_3.dart';
import 'package:learnsmart/pages/course_option.dart';
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    // Accessibility settings applied dynamically
    final fontFamily = settings.dyslexiaFriendly ? 'OpenDyslexic' : 'Inter';
    final textColor =
        settings.highContrast ? Colors.yellow : const Color(0xFF181818);
    final buttonTextColor =
        settings.highContrast ? Colors.yellow : const Color(0xFFFDFDFD);
    final buttonBackgroundColor = settings.highContrast
        ? Colors.black
        : const Color.fromARGB(255, 33, 150, 243);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color:
                settings.highContrast ? Colors.black : const Color(0xFFFDFDFD),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Stack(
                  children: [
                    Positioned(
                      left: -35.1,
                      right: -14.3,
                      top: -13,
                      bottom: 0,
                      child: SizedBox(
                        width: 375,
                        height: 435,
                        child: SvgPicture.asset(
                          'assets/vectors/group_124_x2.svg',
                          color: settings.highContrast ? Colors.yellow : null,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -13,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFDFDFD),
                        ),
                        child: const SizedBox(
                          width: 375,
                          height: 44,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 435,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(35.1, 13, 14.3, 0),
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
                                color: textColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 4.3, 0, 4.3),
                              child: SizedBox(
                                width: 66.7,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0.3, 0, 0.3),
                                      child: SizedBox(
                                        width: 17,
                                        height: 10.7,
                                        child: SvgPicture.asset(
                                          'assets/vectors/cellular_connection_13_x2.svg',
                                          color: settings.highContrast
                                              ? Colors.yellow
                                              : null,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 0.3),
                                      child: SizedBox(
                                        width: 15.3,
                                        height: 11,
                                        child: SvgPicture.asset(
                                          'assets/vectors/wifi_11_x2.svg',
                                          color: settings.highContrast
                                              ? Colors.yellow
                                              : null,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: SizedBox(
                                        width: 24.3,
                                        height: 11.3,
                                        child: SvgPicture.asset(
                                          'assets/vectors/battery_12_x2.svg',
                                          color: settings.highContrast
                                              ? Colors.yellow
                                              : null,
                                        ),
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(33.3, 0, 33.3, 55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Text(
                        'LearnSmart offers personalized learning paths tailored to the unique needs of each child. Engage in fun and interactive lessons across subjects.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: settings.fontSize,
                          height: 1.7,
                          color: textColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox(
                          width: 99,
                          height: 8,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnBoarding3()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(11.7, 0, 11.7, 15),
                        decoration: BoxDecoration(
                          color: buttonBackgroundColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.7,
                              color: buttonTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CourseOption()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(11.7, 0, 11.7, 0),
                        decoration: BoxDecoration(
                          color: settings.highContrast
                              ? Colors.black
                              : const Color(0xFFFDFDFD),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: buttonBackgroundColor),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: settings.fontSize - 2,
                              height: 1.7,
                              color: buttonBackgroundColor,
                            ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AccessibilitySettingsPage()),
          );
        },
        backgroundColor: buttonBackgroundColor,
        child: Icon(
          Icons.settings_accessibility,
          color: buttonTextColor,
        ),
      ),
    );
  }
}
