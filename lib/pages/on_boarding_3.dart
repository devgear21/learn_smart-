import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'course_option.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

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
                          Container(
                            child: Text(
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
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0.3),
                                    child: SizedBox(
                                      width: 15.3,
                                      height: 11,
                                      child: SvgPicture.asset(
                                        'assets/vectors/wifi_11_x2.svg',
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
                      'Discover a world of knowledge with LearnSmart. Track progress and celebrate achievements as your child grows and learns.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.7,
                        color: const Color(0xFF181818),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 150, 243),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: 99,
                        height: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 33, 150, 243),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const SizedBox(
                            width: 99,
                            height: 8,
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
                      margin: const EdgeInsets.fromLTRB(11.7, 0, 11.7, 15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 150, 243),
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
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.7,
                            color: const Color(0xFFFDFDFD),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Remove or comment out the following section to remove the black line
            // Container(
            //   decoration: BoxDecoration(
            //     color: Color(0xFFFDFDFD),
            //   ),
            //   child: Container(
            //     height: 34,
            //     padding: EdgeInsets.fromLTRB(1, 21, 0, 8),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Color(0xFF181818),
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //       child: Container(
            //         width: 134,
            //         height: 5,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
