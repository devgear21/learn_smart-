import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class Course extends StatelessWidget {
  const Course({super.key});

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
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
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
                                'assets/vectors/cellular_connection_9_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.3),
                            child: SizedBox(
                              width: 15.3,
                              height: 11,
                              child: SvgPicture.asset(
                                'assets/vectors/wifi_20_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 24.3,
                              height: 11.3,
                              child: SvgPicture.asset(
                                'assets/vectors/battery_9_x2.svg',
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
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -10,
                        top: 0,
                        child: SizedBox(
                          width: 171,
                          height: 162,
                          child: SvgPicture.asset(
                            'assets/vectors/mask_group_5_x2.svg',
                          ),
                        ),
                      ),
                Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDFDFD),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Container(
                                        width: 78,
                                        padding: const EdgeInsets.fromLTRB(0, 5, 2, 5),
                                        child: Text(
                                          'Biology',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4C6ED7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 10.4, 10),
                                          child: Text(
                                            'Bacterial Biology Overview',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              height: 1.8,
                                              color: const Color(0xFF181818),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF8DA6F4),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: SizedBox(
                                            width: 162,
                                            height: 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4C6ED7),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const SizedBox(
                                                width: 55,
                                                height: 5,
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
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 37),
                              child: SizedBox(
                                width: 162,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: SizedBox(
                                        width: 76,
                                        child: Text(
                                          '5/10 Chapter',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 2, 5.8, 2),
                                          width: 16,
                                          height: 16,
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              'assets/vectors/bxbx_time_8_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '5h 35m left',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    width: 81,
                                    padding: const EdgeInsets.fromLTRB(2.7, 9, 0, 9),
                                    child: Text(
                                      'View',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(19, 9, 18, 9),
                                    child: Text(
                                      'Discuss',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -10,
                        top: 0,
                        child: SizedBox(
                          width: 171,
                          height: 162,
                          child: SvgPicture.asset(
                            'assets/vectors/mask_group_x2.svg',
                          ),
                        ),
                      ),
                Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 9.9, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDFDFD),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Container(
                                        width: 78,
                                        padding: const EdgeInsets.fromLTRB(0, 5, 2, 5),
                                        child: Text(
                                          'Biology',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4C6ED7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Metabolic Biochemistry for High School',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.8,
                                      color: const Color(0xFF181818),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8DA6F4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width: 162,
                                  height: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4C6ED7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const SizedBox(
                                      width: 55,
                                      height: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: SizedBox(
                                width: 162,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: SizedBox(
                                        width: 76,
                                        child: Text(
                                          '5/10 Chapter',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 2, 5.8, 2),
                                          width: 16,
                                          height: 16,
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              'assets/vectors/bxbx_time_7_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '5h 35m left',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    width: 81,
                                    padding: const EdgeInsets.fromLTRB(2.7, 9, 0, 9),
                                    child: Text(
                                      'View',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(19, 9, 18, 9),
                                    child: Text(
                                      'Discuss',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -10,
                        top: -2,
                        child: SizedBox(
                          width: 171,
                          height: 162,
                          child: SvgPicture.asset(
                            'assets/vectors/mask_group_8_x2.svg',
                          ),
                        ),
                      ),
                Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 24.2, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDFDFD),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Container(
                                        width: 78,
                                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          'Biology',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4C6ED7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Mendelian Genetics & Mechanisms of Heredity',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.8,
                                      color: const Color(0xFF181818),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8DA6F4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width: 162,
                                  height: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4C6ED7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const SizedBox(
                                      width: 55,
                                      height: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: SizedBox(
                                width: 162,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: SizedBox(
                                        width: 76,
                                        child: Text(
                                          '5/10 Chapter',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 2, 5.8, 2),
                                          width: 16,
                                          height: 16,
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              'assets/vectors/bxbx_time_10_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '5h 35m left',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    width: 81,
                                    padding: const EdgeInsets.fromLTRB(2.7, 9, 0, 9),
                                    child: Text(
                                      'View',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(19, 9, 18, 9),
                                    child: Text(
                                      'Discuss',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -10,
                        top: 0,
                        child: SizedBox(
                          width: 171,
                          height: 162,
                          child: SvgPicture.asset(
                            'assets/vectors/mask_group_6_x2.svg',
                          ),
                        ),
                      ),
                Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 7.3, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDFDFD),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(7.4, 5, 7.4, 5),
                                        child: Text(
                                          'Mathematics',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4C6ED7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'High School Algebra I: Help and Review',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.8,
                                      color: const Color(0xFF181818),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8DA6F4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width: 162,
                                  height: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4C6ED7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const SizedBox(
                                      width: 55,
                                      height: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: SizedBox(
                                width: 162,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: SizedBox(
                                        width: 76,
                                        child: Text(
                                          '5/10 Chapter',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 2, 5.8, 2),
                                          width: 16,
                                          height: 16,
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              'assets/vectors/bxbx_time_1_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '5h 35m left',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            height: 2,
                                            color: const Color(0xFF4F4F4F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    color: const Color(0xFFFDFDFD),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    width: 81,
                                    padding: const EdgeInsets.fromLTRB(2.7, 9, 0, 9),
                                    child: Text(
                                      'View',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4C6ED7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(19, 9, 18, 9),
                                    child: Text(
                                      'Discuss',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFFFAFAFA),
                                      ),
                                    ),
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
                Stack(
                  children: [
                      Positioned(
                        left: -10,
                        top: 0,
                        child: SizedBox(
                          width: 171,
                          height: 162,
                          child: SvgPicture.asset(
                            'assets/vectors/mask_group_2_x2.svg',
                          ),
                        ),
                      ),
                Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 257,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFDFDFD),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(7.4, 5, 7.4, 5),
                                          child: Text(
                                            'Mathematics',
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              height: 2,
                                              color: const Color(0xFF4C6ED7),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Enlargement to Trigonometry',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.8,
                                        color: const Color(0xFF181818),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF8DA6F4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                width: 162,
                                height: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4C6ED7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const SizedBox(
                                    width: 55,
                                    height: 5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: SizedBox(
                              width: 162,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: SizedBox(
                                      width: 76,
                                      child: Text(
                                        '5/10 Chapter',
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          height: 2,
                                          color: const Color(0xFF4F4F4F),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 2, 5.8, 2),
                                        width: 16,
                                        height: 16,
                                        child: SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: SvgPicture.asset(
                                            'assets/vectors/bxbx_time_6_x2.svg',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '5h 35m left',
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          height: 2,
                                          color: const Color(0xFF4F4F4F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFE0E0E0)),
                                  color: const Color(0xFFFDFDFD),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                  ),
                                ),
                                child: Container(
                                  width: 81,
                                  padding: const EdgeInsets.fromLTRB(2.7, 9, 0, 9),
                                  child: Text(
                                    'View',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.8,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFE0E0E0)),
                                  color: const Color(0xFFFDFDFD),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(19, 9, 18, 9),
                                  child: Text(
                                    'Discuss',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.8,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
            decoration: const BoxDecoration(
              color: Color(0xFFFDFDFD),
              boxShadow: [
                BoxShadow(
                  color: Color(0x17000000),
                  offset: Offset(0, -1),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDFDFD),
                    ),
                    child: Container(
                      height: 68,
                      padding: const EdgeInsets.fromLTRB(1, 24.3, 0, 24),
                      child: SizedBox(
                        width: 20,
                        height: 19.7,
                        child: SizedBox(
                          width: 20,
                          height: 19.7,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_1_x2.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDFDFD),
                    ),
                    child: Stack(
                      children: [
                      Positioned(
                        right: 16,
                        top: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDFDFD),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const SizedBox(
                            width: 93,
                            height: 38,
                          ),
                        ),
                      ),
                Container(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 10, 1),
                                child: SizedBox(
                                  width: 15,
                                  height: 20,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(2.7, 1.5, 0.3, 17.5),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF4C6ED7),
                                          ),
                                          child: const SizedBox(
                                            width: 12,
                                            height: 1,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -17.5,
                                          child: SizedBox(
                                            width: 15,
                                            height: 20,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_15_x2.svg',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Course',
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
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDFDFD),
                    ),
                    child: Container(
                      height: 68,
                      padding: const EdgeInsets.fromLTRB(1, 24, 0, 24),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_8_x2.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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