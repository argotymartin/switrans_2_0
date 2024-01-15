import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/logo_multicompany.png', width: 50, height: 50),
        const SizedBox(height: 20),
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'Ingresar Ahora',
            style: GoogleFonts.montserratAlternates(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
