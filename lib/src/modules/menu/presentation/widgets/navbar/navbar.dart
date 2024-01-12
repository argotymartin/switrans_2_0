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
          height: 66,
          decoration: buidBoxDecoration(context),
          child: const Row(
            children: [
              SizedBox(width: 10),
              Spacer(),
              IconNavbar(icon: Icons.report_gmailerrorred_outlined),
              SizedBox(width: 16),
              IconNavbar(icon: Icons.check_box_outline_blank_rounded),
              SizedBox(width: 16),
              IconNavbar(icon: Icons.group_work_outlined, title: "!"),
              SizedBox(width: 16),
              IconNavbar(icon: Icons.notifications_outlined, title: "11"),
              SizedBox(width: 16),
              AvatarNavbar(size: 32),
              SizedBox(width: 48),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          width: 60,
          child: const MenuButtonNavar(),
        ),
      ],
    );
  }

  BoxDecoration buidBoxDecoration(BuildContext context) => BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            blurRadius: 22,
          )
        ],
      );
}
