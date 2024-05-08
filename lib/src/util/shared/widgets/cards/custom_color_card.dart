import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/config/themes/custom_colors.dart';

class CustomColorCard extends StatelessWidget {
  final String? title;
  final double? width;
  final Widget child;
  final IconData icon;
  const CustomColorCard({
    required this.child,
    required this.icon,
    this.title,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: buildBoxDeoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) ...<Widget>[
            Container(
              height: 48,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    customColorFuchsiaBlue.shade400,
                    customColorFuchsiaBlue.shade300,
                  ],
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  const SizedBox(width: 4),
                  FittedBox(
                    child: Text(
                      title!,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDeoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
        color: Colors.white,
      );
}
