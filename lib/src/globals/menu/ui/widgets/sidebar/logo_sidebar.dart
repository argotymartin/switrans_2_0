import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoSidebar extends StatelessWidget {
  final bool isMenuIcon;
  const LogoSidebar({super.key, required this.isMenuIcon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 66,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/empresas/icon-multicompany.png",
              height: 48,
            ),
            const SizedBox(width: 10),
            isMenuIcon
                ? const SizedBox()
                : Text(
                    'SWITRANS 2.0',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
