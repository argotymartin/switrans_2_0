import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/empresas/icon-multicompany.png', width: 60, height: 60),
        const SizedBox(height: 20),
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'Ingreso Switrans 2.0',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        )
      ],
    );
  }
}
