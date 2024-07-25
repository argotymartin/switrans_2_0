import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final Color color;
  final int themeModeCode;
  AppTheme(this.color, this.themeModeCode);

  static late Color colorThemePrimary;
  static late Color colorThemeSecundary;
  static late Color colorTextTheme;

  ThemeData getTheme(BuildContext context) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).copyWith(
        bodyMedium: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
        titleMedium: const TextStyle(fontSize: 12),
        titleLarge: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black54)),
      ),
      brightness: themeModeCode == 2 ? Brightness.dark : Brightness.light,
      canvasColor: color,
      primaryTextTheme: Theme.of(context).textTheme,
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
    if (themeModeCode == 1) {
      colorThemePrimary = theme.colorScheme.surfaceContainerLowest;
      colorThemeSecundary = theme.colorScheme.surfaceContainerLowest;
      colorTextTheme = Colors.black;
    } else if (themeModeCode == 2) {
      colorThemePrimary = Colors.black38;
      colorThemeSecundary = theme.colorScheme.surfaceContainerHighest;
      colorTextTheme = Colors.white;
    } else {
      colorThemePrimary = theme.colorScheme.surfaceContainerLowest;
      colorThemeSecundary = theme.colorScheme.surfaceContainerLowest;
      colorTextTheme = Colors.black;
    }
    return theme;
  }

  static final TextStyle titleStyle = GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400);
}
