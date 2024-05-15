import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final Color colorText;
  final bool isFilled;
  final IconData? icon;

  const CustomOutlinedButton({
    required this.onPressed,
    required this.text,
    this.colorText = Colors.black,
    this.color = Colors.blue,
    this.isFilled = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? OutlinedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(color),
              foregroundColor: WidgetStatePropertyAll<Color>(color),
            ),
            onPressed: () => onPressed(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 16, color: colorText),
              ),
            ),
          )
        : OutlinedButton.icon(
            icon: Icon(icon, color: colorText),
            style: ButtonStyle(
              side: WidgetStateProperty.all(BorderSide(color: color)),
              backgroundColor: WidgetStatePropertyAll<Color>(color),
              foregroundColor: WidgetStatePropertyAll<Color>(color),
            ),
            onPressed: () => onPressed(),
            label: Text(
              text,
              style: TextStyle(fontSize: 16, color: colorText),
            ),
          );
  }
}
