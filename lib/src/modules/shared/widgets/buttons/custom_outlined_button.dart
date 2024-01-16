import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final Color colorText;
  final bool isFilled;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.colorText = Colors.black,
    this.color = Colors.blue,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        foregroundColor: MaterialStatePropertyAll(color),
      ),
      onPressed: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: colorText),
        ),
      ),
    );
  }
}
