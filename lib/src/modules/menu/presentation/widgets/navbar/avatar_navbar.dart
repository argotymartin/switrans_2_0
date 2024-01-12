import 'package:flutter/material.dart';

class AvatarNavbar extends StatelessWidget {
  final double size;
  const AvatarNavbar({super.key, required this.size});

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
