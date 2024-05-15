import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final Color color;
  AppTheme({this.color = Colors.black});
  ThemeData getTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      //brightness: Brightness.dark,
      textTheme: GoogleFonts.robotoTextTheme(theme.textTheme).copyWith(
        bodyMedium: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
        titleMedium: const TextStyle(fontSize: 12),
        titleLarge: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black54)),
      ),
      colorSchemeSeed: color,
      iconTheme: IconThemeData(color: color),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 12),
        labelStyle: TextStyle(fontSize: 12),
      ),
      textSelectionTheme: const TextSelectionThemeData(),
      dataTableTheme: const DataTableThemeData(checkboxHorizontalMargin: 20),
      scrollbarTheme: ScrollbarThemeData(
        thickness: WidgetStateProperty.all(16),
        radius: const Radius.circular(6),
        thumbColor: WidgetStateProperty.all(Colors.grey),
        trackColor: WidgetStateProperty.all(Colors.blueGrey),
        crossAxisMargin: 0,
        thumbVisibility: const WidgetStatePropertyAll<bool>(true),
        interactive: true,
      ),
    );
  }

  static final TextStyle titleStyle = GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87);
}
