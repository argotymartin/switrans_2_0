// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomSizeButton extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final VoidCallback onPressed;

  const CustomSizeButton({
    super.key,
    required this.width,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(width * 0.8),
          padding: MaterialStatePropertyAll(EdgeInsetsDirectional.symmetric(horizontal: width * 0.1)),
          shape: const MaterialStatePropertyAll(StadiumBorder()),
          backgroundColor: MaterialStatePropertyAll(color),
        ),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
