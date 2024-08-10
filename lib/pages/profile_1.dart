import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class Profile1 extends StatelessWidget {
  const Profile1({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDFD),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
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
                                'assets/vectors/cellular_connection_14_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.3),
                            child: SizedBox(
                              width: 15.3,
                              height: 11,
                              child: SvgPicture.asset(
                                'assets/vectors/wifi_13_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 24.3,
                              height: 11.3,
                              child: SvgPicture.asset(
                                'assets/vectors/battery_20_x2.svg',
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
            margin: const EdgeInsets.fromLTRB(1, 0, 0, 32),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/national_cancer_institute_l_7_en_7_lb_ovc_unsplash_1.png',
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                          Positioned(
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/national_cancer_institute_l_7_en_7_lb_ovc_unsplash_1.png',
                                  ),
                                ),
                              ),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                    SizedBox(
                              width: 100,
                              height: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/national_cancer_institute_l_7_en_7_lb_ovc_unsplash_1.png',
                                    ),
                                  ),
                                ),
                                child: const SizedBox(
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 17.7, 0),
                      child: Text(
                        'Ali Raza',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          height: 1.6,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '@aliraza.123',
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
                  ],
                ),
                Positioned(
                  left: 15,
                  bottom: 22,
                  child: SizedBox(
                    height: 28,
                    child: Text(
                      'Ali Raza',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        height: 1.6,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  bottom: 0,
                  child: SizedBox(
                    height: 22,
                    child: Text(
                      '@aliraza.123',
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
                Positioned(
                  left: 15,
                  bottom: 22,
                  child: SizedBox(
                    height: 28,
                    child: Text(
                      'Ali Raza',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        height: 1.6,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  bottom: 0,
                  child: SizedBox(
                    height: 22,
                    child: Text(
                      '@aliraza.123',
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
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 37),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C6ED7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(2, 15, 0, 15),
                          child: Text(
                            'General',
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
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFDFDFD),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            'Badges',
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.7,
                              color: const Color(0xFF4F4F4F),
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
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDFDFD),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 17),
                    child: Text(
                      'Edit',
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
                Positioned(
                  left: 16,
                  bottom: 5,
                  child: SizedBox(
                    width: 71.4,
                    height: 47,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 4.2, 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xFFFDFDFD),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.fromLTRB(4, 5.4, 4, 4),
                                  child: SizedBox(
                                    width: 16,
                                    height: 14.6,
                                    child: SizedBox(
                                      width: 16,
                                      height: 14.6,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_13_x2.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                                child: Text(
                                  'Name',
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.8,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            'Ali Raza',
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
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFFDFDFD),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(0, 4),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.fromLTRB(5, 6.5, 5, 6.5),
                            child: SizedBox(
                              width: 14,
                              height: 11,
                              child: SizedBox(
                                width: 14,
                                height: 11,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_14_x2.svg',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Email',
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.8,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'ali.aza123@mail.com',
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
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 13, 0, 12),
                      child: Text(
                        'Edit',
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
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFFDFDFD),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(0, 4),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.fromLTRB(6, 4.7, 6, 5.3),
                            child: SizedBox(
                              width: 12,
                              height: 14,
                              child: SizedBox(
                                width: 12,
                                height: 14,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_12_x2.svg',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Password',
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.8,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Tap to Change Password',
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
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 13, 0, 12),
                      child: Text(
                        'Edit',
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
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFFDFDFD),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(0, 4),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.fromLTRB(7.3, 4.7, 8, 4.7),
                            child: SizedBox(
                              width: 8.7,
                              height: 14.7,
                              child: SizedBox(
                                width: 8.7,
                                height: 14.7,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_48_x2.svg',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 11.9, 5),
                              child: Text(
                                'Phone Number',
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1.8,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ),
                            Text(
                              '0092-000-0000000',
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
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 13, 0, 12),
                      child: Text(
                        'Edit',
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
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 1, 191),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
              ),
              child: SizedBox(
                width: 375,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 5, 24.5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 23),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xFFFDFDFD),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(0, 4),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.fromLTRB(6, 4.8, 6, 4.7),
                              child: SizedBox(
                                width: 12,
                                height: 14.5,
                                child: SizedBox(
                                  width: 12,
                                  height: 14.5,
                                  child: SvgPicture.asset(
                                    'assets/vectors/vector_10_x2.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Privacy Policy',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.8,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Tap to See Privacy Policy',
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
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 19, 0, 18),
                        width: 6,
                        height: 10,
                        child: SizedBox(
                          width: 6,
                          height: 10,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_44_x2.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
            child: Text(
              'LOG OUT',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.6,
                color: const Color(0xFF4C6ED7),
              ),
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
                      padding: const EdgeInsets.fromLTRB(0, 24.3, 1, 24),
                      child: SizedBox(
                        width: 20,
                        height: 19.7,
                        child: SizedBox(
                          width: 20,
                          height: 19.7,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_36_x2.svg',
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
                    child: Container(
                      height: 68,
                      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
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
                                  color: Color(0xFF4F4F4F),
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
                                    'assets/vectors/vector_43_x2.svg',
                                  ),
                                ),
                              ),
                            ],
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 7, 1),
                                width: 20,
                                height: 20,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(
                                    'assets/vectors/vector_21_x2.svg',
                                  ),
                                ),
                              ),
                              Text(
                                'Account',
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