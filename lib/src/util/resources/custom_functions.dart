import 'package:flutter/material.dart';

class CustomFunctions {
  static String limpiarTexto(String texto) {
    return texto.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static Color oscurecerColor(Color color, double factor) {
    final int red = (color.red * factor).round();
    final int green = (color.green * factor).round();
    final int blue = (color.blue * factor).round();

    return Color.fromRGBO(red, green, blue, color.opacity);
  }

  static String formatPath(String text) {
    return "/${text.toLowerCase().replaceAll(RegExp(r'\/'), '_').replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}";
  }

  static String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
