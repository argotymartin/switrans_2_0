import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xff183650), Colors.white]),
        image: DecorationImage(
          image: AssetImage('assets/slider_1.jpg'),
          fit: BoxFit.cover,
          opacity: 0.8,
        ),
      ),
    );
  }
}
