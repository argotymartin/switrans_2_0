// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomSizeButton extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color? color;
  final Color? iconColor;

  const CustomSizeButton({
    Key? key,
    required this.width,
    required this.icon,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(width * 0.8),
          padding: MaterialStatePropertyAll(EdgeInsetsDirectional.symmetric(horizontal: width * 0.1)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
          backgroundColor: MaterialStatePropertyAll(color),
        ),
        onPressed: () {},
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
