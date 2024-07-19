import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class TextSeparatorSidebar extends StatelessWidget {
  final String text;
  const TextSeparatorSidebar({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        Color colorText = Colors.black;
        if (state.themeMode == 1) {
          colorText = Colors.white.withOpacity(0.3);
        } else if (state.themeMode == 2) {
          colorText = Colors.white.withOpacity(0.6);
        } else {
          colorText = Colors.black;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 5),
          child: Text(
            text,
            style: GoogleFonts.roboto(
              color: colorText,
              fontSize: 12,
            ),
          ),
        );
      },
    );
  }
}
