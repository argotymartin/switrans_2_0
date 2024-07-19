import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class LogoSidebar extends StatelessWidget {
  final bool isMenuIcon;
  const LogoSidebar({
    required this.isMenuIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        Color colorText = Colors.black;
        if (state.themeMode == 1) {
          colorText = Colors.white;
        } else if (state.themeMode == 2) {
          colorText = Colors.white.withOpacity(0.6);
        } else {
          colorText = Colors.black;
        }
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
                          color: colorText,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
