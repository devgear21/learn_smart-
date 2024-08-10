import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class DetailCoursePreview extends StatelessWidget {
  const DetailCoursePreview({super.key});

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
            top: 0,
            child: SizedBox(
              width: 375,
              height: 355,
              child: SvgPicture.asset(
                'assets/vectors/course_preview_1_x2.svg',
              ),
            ),
          ),
    Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 11),
                decoration: const BoxDecoration(
                  color: Color(0xFFFDFDFD),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      offset: Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ],
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
                                    'assets/vectors/cellular_connection_7_x2.svg',
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.3),
                                child: SizedBox(
                                  width: 15.3,
                                  height: 11,
                                  child: SvgPicture.asset(
                                    'assets/vectors/wifi_9_x2.svg',
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  width: 24.3,
                                  height: 11.3,
                                  child: SvgPicture.asset(
                                    'assets/vectors/battery_16_x2.svg',
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
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 154),
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
                            'assets/vectors/vector_53_x2.svg',
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 49, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 3, 9.6, 0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.25,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4C6ED7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const SizedBox(
                                      width: 58,
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                                            child: SizedBox(
                                              width: 271.6,
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
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 2, 0, 26),
                                            child: Text(
                                              'Medium',
                                              style: GoogleFonts.getFont(
                                                'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                height: 2,
                                                color: const Color(0xFF4C6ED7),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                                    text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitasse dolor etiam sed ante donec quis sapien. Malesuada rhoncus nullam eleifend lorem egestas mauris massa massa.',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.3,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ',
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
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Information',
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 9.6, 17),
                                child: SizedBox(
                                  width: 234.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 3, 10, 3),
                                            width: 16,
                                            height: 16,
                                            child: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: SvgPicture.asset(
                                                'assets/vectors/bxbx_time_4_x2.svg',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '12h 35m',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              height: 1.8,
                                              color: const Color(0xFF4C6ED7),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 4.3, 13.3, 4.3),
                                            child: SizedBox(
                                              width: 10,
                                              height: 13.3,
                                              child: Container(
                                                padding: const EdgeInsets.fromLTRB(1.8, 1, 0.2, 11.7),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xFF4C6ED7),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 8,
                                                        height: 0.7,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: -11.7,
                                                      child: SizedBox(
                                                        width: 10,
                                                        height: 13.3,
                                                        child: SvgPicture.asset(
                                                          'assets/vectors/vector_47_x2.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '12 chapter',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              height: 1.8,
                                              color: const Color(0xFF4C6ED7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 244.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                                          width: 16,
                                          height: 12,
                                          child: SizedBox(
                                            width: 16,
                                            height: 12,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_7_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '45 students',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.8,
                                            color: const Color(0xFF4C6ED7),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 4.3, 11.3, 4.3),
                                          width: 13.3,
                                          height: 13.3,
                                          child: SizedBox(
                                            width: 13.3,
                                            height: 13.3,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_56_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '350 reviews',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.8,
                                            color: const Color(0xFF4C6ED7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 15),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Sylabus',
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                                child: SizedBox(
                                                  width: 318.7,
                                                  child: Text(
                                                    'Introduction',
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
                                                margin: const EdgeInsets.fromLTRB(0, 6.3, 0, 14.3),
                                                width: 10.7,
                                                height: 1.3,
                                                child: SizedBox(
                                                  width: 10.7,
                                                  height: 1.3,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/vector_39_x2.svg',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 6.1, 0),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Semper et eu, commodo, lacus. Semper urna nunc dictum duis adipiscing aenean scelerisque in porta. Magna viverra auctor tortor elementum. Arcu cras egestas erat condimentum mattis quam justo.',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              height: 2,
                                              color: const Color(0xFF4F4F4F),
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
                                          'assets/vectors/vector_18_x2.svg',
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                            margin: const EdgeInsets.fromLTRB(0, 6.3, 0, 14.3),
                                            width: 10.7,
                                            height: 1.3,
                                            child: SizedBox(
                                              width: 10.7,
                                              height: 1.3,
                                              child: SvgPicture.asset(
                                                'assets/vectors/vector_26_x2.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 10.5, 0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Semper et eu, commodo, lacus. ',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Learn More',
                                              style: GoogleFonts.getFont(
                                                'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                height: 1.3,
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
                                          'assets/vectors/vector_33_x2.svg',
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
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 34),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE0E0E0),
                                ),
                                child: const SizedBox(
                                  width: 375,
                                  height: 1,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 0, 15.5, 0),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: Opacity(
                                      opacity: 0.25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4C6ED7),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: const SizedBox(
                                          width: 72,
                                          height: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Price',
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
                                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                                child: SizedBox(
                                                  width: 106.9,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                                        child: SizedBox(
                                                          width: 66,
                                                          child: Text(
                                                            'Discount',
                                                            style: GoogleFonts.getFont(
                                                              'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12,
                                                              height: 1.8,
                                                              color: const Color(0xFF4C6ED7),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$240',
                                                        style: GoogleFonts.getFont(
                                                          'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12,
                                                          decoration: TextDecoration.lineThrough,
                                                          height: 1.8,
                                                          color: const Color(0xFF4F4F4F),
                                                          decorationColor: const Color(0xFF4F4F4F),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '\$120',
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  height: 1.6,
                                                  color: const Color(0xFF4C6ED7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            '(Save 50%)',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              height: 2,
                                              color: const Color(0xFF4C6ED7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 35),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C6ED7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(1, 16, 0, 16),
                            child: Text(
                              'Buy Course',
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