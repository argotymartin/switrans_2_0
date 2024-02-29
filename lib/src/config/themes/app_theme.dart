import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final Color color;
  AppTheme({this.color = Colors.black});
  ThemeData getTheme(BuildContext context) {
    final theme = Theme.of(context);
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
        //isAlwaysShown: true, // Mostrar siempre la barra de desplazamiento
        thickness: MaterialStateProperty.all(16.0), // Grosor de la barra
        radius: const Radius.circular(6.0), // Radio de los bordes de la barra
        thumbColor: MaterialStateProperty.all(Colors.grey), // Color del pulgar de la barra
        trackColor: MaterialStateProperty.all(Colors.blueGrey), // Color del riel de la barra
        crossAxisMargin: 0,
        thumbVisibility: const MaterialStatePropertyAll(true),
        interactive: true,
      ),
    );
  }

  static final titleStyle = GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87);
}
