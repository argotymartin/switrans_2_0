import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 66,
          decoration: buidBoxDecoration(context),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 10),
              const Spacer(),
              IconNavbar(
                icon: Icons.settings_outlined,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
              const SizedBox(width: 16),
              IconNavbar(
                icon: Icons.check_box_outline_blank_rounded,
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              IconNavbar(
                icon: Icons.group_work_outlined,
                title: "!",
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              IconNavbar(
                icon: Icons.notifications_outlined,
                title: "11",
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              const AvatarNavbar(size: 32),
              const SizedBox(width: 48),
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
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            blurRadius: 22,
          ),
        ],
      );
}
