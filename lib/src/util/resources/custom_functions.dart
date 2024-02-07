import 'package:flutter/material.dart';

class CustomFunctions {
  static String limpiarTexto(String texto) {
    return texto.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static Color oscurecerColor(Color color, double factor) {
    int red = (color.red * factor).round();
    int green = (color.green * factor).round();
    int blue = (color.blue * factor).round();

    return Color.fromRGBO(red, green, blue, color.opacity);
  }
}
