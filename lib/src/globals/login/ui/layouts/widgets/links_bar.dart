import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: const Color(0xff183650),
      height: size.width > 1000 ? size.height * 0.054 : null,
      child: const Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(text: "Home"),
          LinkText(text: "Nosotros"),
          LinkText(text: "Ayuda"),
          LinkText(text: "Terminos y condiciones"),
          LinkText(text: "Politica de privacidad"),
        ],
      ),
    );
  }
}
