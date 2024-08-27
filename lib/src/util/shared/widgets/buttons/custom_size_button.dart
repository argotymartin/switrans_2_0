import 'package:flutter/material.dart';

class CustomSizeButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final VoidCallback onPressed;

  const CustomSizeButton({
    required this.size,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          style: ButtonStyle(
            iconSize: WidgetStatePropertyAll<double>(size * 0.6),
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsetsDirectional.symmetric(horizontal: size * 0.1)),
            shape: const WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder()),
            backgroundColor: WidgetStatePropertyAll<Color?>(color),
          ),
          onPressed: onPressed,
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
