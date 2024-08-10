import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class CourseQuiz2 extends StatelessWidget {
  const CourseQuiz2({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDFD),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFDFDFD),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(35.1, 13, 14.3, 11),
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
                            margin: const EdgeInsets.fromLTRB(0, 0.3, 0, 0.3),
                            child: SizedBox(
                              width: 17,
                              height: 10.7,
                              child: SvgPicture.asset(
                                'assets/vectors/cellular_connection_15_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.3),
                            child: SizedBox(
                              width: 15.3,
                              height: 11,
                              child: SvgPicture.asset(
                                'assets/vectors/wifi_19_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 24.3,
                              height: 11.3,
                              child: SvgPicture.asset(
                                'assets/vectors/battery_1_x2.svg',
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
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 16, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: SvgPicture.asset(
                          'assets/vectors/vector_16_x2.svg',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8DA6F4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 214,
                          height: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF4C6ED7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const SizedBox(
                              width: 214,
                              height: 8,
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
          Container(
            margin: const EdgeInsets.fromLTRB(18.7, 0, 18.7, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitasse dolor etiam sed ante donec quis sapien?',
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                  child: Text(
                    '15 Of 15',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.8,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 242),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 23, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF9D9B9B)),
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFFDFDFD),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(1, 20, 0, 20),
                            child: Text(
                              'A. Lorem Ipsum',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                                color: const Color(0xFF181818),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF9D9B9B)),
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFFDFDFD),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(1, 20, 0, 20),
                            child: Text(
                              'B. Lorem Ipsum',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                                color: const Color(0xFF181818),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 23, 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF9D9B9B)),
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFFDFDFD),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                            'C. Lorem Ipsum',
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.7,
                              color: const Color(0xFF181818),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C6ED7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                            'D. Lorem Ipsum',
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.7,
                              color: const Color(0xFFFDFDFD),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 59),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4C6ED7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(
                  'Finish',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    height: 1.6,
                    color: const Color(0xFFFDFDFD),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFDFDFD),
            ),
            child: Container(
              height: 34,
              padding: const EdgeInsets.fromLTRB(1, 21, 0, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF181818),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const SizedBox(
                  width: 134,
                  height: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}