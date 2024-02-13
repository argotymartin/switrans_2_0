import 'package:flutter/services.dart';

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(), // Convertir el texto a mayúsculas
      selection: newValue.selection, // Mantener la selección del texto
    );
  }
}
