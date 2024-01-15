import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(image: AssetImage('assets/mct1.jpg'), fit: BoxFit.cover, opacity: 0.4),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: AssetImage('assets/logo_multicompany.png'),
              width: 400,
            ),
          ),
        ),
      ),
    );
  }
}
