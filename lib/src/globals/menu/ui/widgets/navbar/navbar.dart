import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 66,
          decoration: buidBoxDecoration(context),
          child: BlocBuilder<MenuBloc, MenuState>(
            builder: (BuildContext context, MenuState state) {
              return Row(
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
                  size.width > 560
                      ? IconNavbar(
                          icon: Icons.check_box_outline_blank_rounded,
                          onPressed: () {},
                        )
                      : const SizedBox(),
                  size.width > 560 ? const SizedBox(width: 16) : const SizedBox(),
                  size.width > 520
                      ? IconNavbar(
                          icon: Icons.group_work_outlined,
                          title: "!",
                          onPressed: () {},
                        )
                      : const SizedBox(),
                  size.width > 520 ? const SizedBox(width: 16) : const SizedBox(),
                  size.width > 480
                      ? IconNavbar(
                          icon: Icons.notifications_outlined,
                          title: "11",
                          onPressed: () {},
                        )
                      : const SizedBox(),
                  size.width > 480 ? const SizedBox(width: 16) : const SizedBox(),
                ],
              );
            },
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
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Theme.of(context).colorScheme.shadow.withOpacity(0.2), blurRadius: 22, offset: const Offset(22, 0)),
        ],
      );
}
