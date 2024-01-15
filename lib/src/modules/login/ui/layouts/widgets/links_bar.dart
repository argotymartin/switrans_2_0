import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      height: size.width > 1000 ? size.height * 0.07 : null,
      child: const Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(text: "home"),
          LinkText(text: "About"),
          LinkText(text: "Help Center"),
          LinkText(text: "Terms of Service"),
          LinkText(text: "Privacy Policy"),
          LinkText(text: "Cppkie Policy"),
          LinkText(text: "Ads Info"),
          LinkText(text: "Blogs"),
          LinkText(text: "Status"),
          LinkText(text: "Care Center"),
          LinkText(text: "Adverter"),
          LinkText(text: "Brand Resources"),
        ],
      ),
    );
  }
}
