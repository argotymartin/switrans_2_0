import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoSidebar extends StatelessWidget {
  final bool isMenuIcon;
  const LogoSidebar({
    required this.isMenuIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 66,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                  ),
          ],
        ),
      ),
    );
  }
}
