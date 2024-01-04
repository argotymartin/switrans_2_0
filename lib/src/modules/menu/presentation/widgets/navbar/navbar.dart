import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/widgets/widgets.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 62,
          decoration: buidBoxDecoration(),
          child: const Row(
            children: [
              SizedBox(width: 10),
              Spacer(),
              NotificationIndicatorNavbar(),
              SizedBox(width: 10),
              //NavbarAvatar(),
              SizedBox(width: 10),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          width: 60,
          child: const MenuButtonNavar(),
        ),
      ],
    );
  }

  BoxDecoration buidBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          )
        ],
      );
}
