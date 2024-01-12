import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/config/themes/custom_colors.dart';

class AppTheme {
  ThemeData getTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.robotoTextTheme(theme.textTheme).copyWith(
        bodyMedium: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
        titleMedium: const TextStyle(fontSize: 12),
        titleLarge: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black54)),
      ),
      colorSchemeSeed: customColorMct,
      iconTheme: IconThemeData(color: theme.primaryColor),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 12),
        labelStyle: TextStyle(fontSize: 12),
      ),
      textSelectionTheme: const TextSelectionThemeData(),
      dataTableTheme: const DataTableThemeData(checkboxHorizontalMargin: 20),
    );
  }
}
