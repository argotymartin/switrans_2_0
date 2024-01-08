import 'package:flutter/material.dart';

class AvatarNavbar extends StatelessWidget {
  final double size;
  const AvatarNavbar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        'https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352010-stock-illustration-default-placeholder-man-and-woman.jpg',
        height: size,
        width: size,
      ),
    );
  }
}
