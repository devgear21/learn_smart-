import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class DetailCourseStart extends StatelessWidget {
  const DetailCourseStart({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDFD),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -0.6,
            child: SizedBox(
              width: 375,
              height: 355.3,
              child: SvgPicture.asset(
                'assets/vectors/course_preview_x2.svg',
              ),
            ),
          ),
    Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 11),
                child: Container(
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
                                      'assets/vectors/cellular_connection_2_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.3),
                                  child: SizedBox(
                                    width: 15.3,
                                    height: 11,
                                    child: SvgPicture.asset(
                                      'assets/vectors/wifi_1_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: SizedBox(
                                    width: 24.3,
                                    height: 11.3,
                                    child: SvgPicture.asset(
                                      'assets/vectors/battery_3_x2.svg',
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
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 157),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: 32,
                      height: 32,
                      padding: const EdgeInsets.fromLTRB(9.3, 10, 9.3, 10),
                      child: SizedBox(
                        width: 13.3,
                        height: 12,
                        child: SizedBox(
                          width: 13.3,
                          height: 12,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_55_x2.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFDFDFD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 49, 0, 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'High School Algebra I: Help and Review',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                  child: SizedBox(
                                    width: 226,
                                    child: Text(
                                      'Mathematics',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF4F4F4F),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 5.7, 0),
                                        child: Text(
                                          '5/12',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 6),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF8DA6F4),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: SizedBox(
                                            width: 80,
                                            height: 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4C6ED7),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const SizedBox(
                                                width: 34,
                                                height: 4,
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
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 35.1, 51),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Description',
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
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1.8,
                                  color: const Color(0xFF4F4F4F),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitasse dolor etiam sed ante donec quis sapien. Malesuada rhoncus nullam eleifend lorem egestas mauris massa massa',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.3,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '. ',
                                  ),
                                  TextSpan(
                                    text: 'More',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.3,
                                      color: const Color(0xFF4C6ED7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Next Chapter',
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
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFDFDFD),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(16, 10, 18.7, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                          child: SizedBox(
                                            width: 318.7,
                                            child: Text(
                                              'Basic Arithmetic',
                                              style: GoogleFonts.getFont(
                                                'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                height: 1.8,
                                                color: const Color(0xFF181818),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 5.7, 0, 5.7),
                                          width: 10.7,
                                          height: 10.7,
                                          child: SizedBox(
                                            width: 10.7,
                                            height: 10.7,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_54_x2.svg',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 10, 18.7, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                      child: SizedBox(
                                        width: 318.7,
                                        child: Text(
                                          'Solving Math Word Problems',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.8,
                                            color: const Color(0xFF181818),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 10.3, 0, 10.3),
                                      width: 10.7,
                                      height: 1.3,
                                      child: SizedBox(
                                        width: 10.7,
                                        height: 1.3,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_51_x2.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 9.5, 17.5, 9.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0.5, 10, 0.5),
                                      child: SizedBox(
                                        width: 310.5,
                                        child: Text(
                                          'Lesson 1: Solving Word Problems: Steps & Examples',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF181818),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 21,
                                      height: 21,
                                      child: SizedBox(
                                        width: 21,
                                        height: 21,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_34_x2.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 9.5, 17.5, 9.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0.5, 10, 0.5),
                                      child: SizedBox(
                                        width: 310.5,
                                        child: Text(
                                          'Lesson 2: Solving Word Problems with Multiple Steps',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF181818),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 21,
                                      height: 21,
                                      child: SizedBox(
                                        width: 21,
                                        height: 21,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_3_x2.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 9.5, 17.5, 9.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0.5, 10, 0.5),
                                      child: SizedBox(
                                        width: 310.5,
                                        child: Text(
                                          'Lesson 3: Restating Word Problems Using Words or Images',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF181818),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 21,
                                      height: 21,
                                      child: SizedBox(
                                        width: 21,
                                        height: 21,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_46_x2.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 10, 18.7, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                      child: SizedBox(
                                        width: 318.7,
                                        child: Text(
                                          'Quiz',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.8,
                                            color: const Color(0xFF181818),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 10.3, 0, 10.3),
                                      width: 10.7,
                                      height: 1.3,
                                      child: SizedBox(
                                        width: 10.7,
                                        height: 1.3,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_28_x2.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 10, 26.6, 10),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: -10.6,
                                      bottom: -5,
                                      child: Opacity(
                                        opacity: 0.25,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4C6ED7),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const SizedBox(
                                            width: 67,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                            child: SizedBox(
                                              width: 276,
                                              child: Text(
                                                'Practicing Mixture Problems in Algebra',
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  height: 2,
                                                  color: const Color(0xFF181818),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Take Quiz',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              height: 2,
                                              color: const Color(0xFF4C6ED7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDFDFD),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 10, 18.7, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                      child: SizedBox(
                                        width: 318.7,
                                        child: Text(
                                          'Decimals and Fractions',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.8,
                                            color: const Color(0xFF181818),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 5.7, 0, 5.7),
                                      width: 10.7,
                                      height: 10.7,
                                      child: SizedBox(
                                        width: 10.7,
                                        height: 10.7,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_32_x2.svg',
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
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 34),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C6ED7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(1, 16, 0, 16),
                            child: Text(
                              'Start Course',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}