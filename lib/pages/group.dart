import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Group extends StatelessWidget {
  const Group({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
          Positioned(
            left: -0.7,
            right: -4,
            top: 0,
            bottom: -0.3,
            child: SizedBox(
              width: 9.4,
              height: 3.9,
              child: SvgPicture.asset(
                'assets/vectors/vector_29_x2.svg',
              ),
            ),
          ),
          Positioned(
            right: -4,
            top: 1.7,
            child: Opacity(
              opacity: 0.25,
              child: SizedBox(
                width: 6.5,
                height: 1.7,
                child: SvgPicture.asset(
                  'assets/vectors/vector_40_x2.svg',
                ),
              ),
            ),
          ),
    Container(
          padding: const EdgeInsets.fromLTRB(0.7, 0, 4, 0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 1.8),
                child: SizedBox(
                  width: 4.7,
                  height: 1.2,
                  child: SvgPicture.asset(
                    'assets/vectors/container_x2.svg',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0.6, 0, 0.3, 0),
                child: Opacity(
                  opacity: 0.25,
                  child: SizedBox(
                    width: 3.9,
                    height: 0.6,
                    child: SvgPicture.asset(
                      'assets/vectors/vector_5_x2.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}