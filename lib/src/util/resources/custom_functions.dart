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
}
