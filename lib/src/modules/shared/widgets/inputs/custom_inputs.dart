import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.3,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.6)),
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        errorStyle: TextStyle(color: Colors.red.shade200));
  }

  static InputDecoration searchInputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }
}
