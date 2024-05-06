import 'package:flutter/material.dart';

class AvatarNavbar extends StatelessWidget {
  final double size;
  const AvatarNavbar({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/profile/perfil_hombre.jpg',
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
