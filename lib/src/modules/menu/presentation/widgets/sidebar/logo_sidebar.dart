import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoSidebar extends StatelessWidget {
  final bool isMenuIcon;
  const LogoSidebar({super.key, required this.isMenuIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bubble_chart_outlined,
            color: Color(0xff7a6bf5),
          ),
          const SizedBox(width: 10),
          isMenuIcon
              ? const SizedBox()
              : Text(
                  'SmartAdmin WebApp',
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                )
        ],
      ),
    );
  }
}
