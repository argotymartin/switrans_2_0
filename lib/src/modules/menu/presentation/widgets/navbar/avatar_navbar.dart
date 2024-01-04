import 'package:flutter/material.dart';

class AvatarNavbar extends StatelessWidget {
  const AvatarNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        'https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352010-stock-illustration-default-placeholder-man-and-woman.jpg',
        height: 48,
        width: 48,
      ),
    );
  }
}
