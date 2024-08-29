import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/navbar/custom_end_drawer.dart';

class MenuLayout extends StatelessWidget {
  final Widget child;
  const MenuLayout({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        endDrawer: const CustomEndDrawer(),
        body: FadeIn(
          duration: const Duration(seconds: 1),
          child: Row(
            children: <Widget>[
              const Sidebar(),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 66,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4, left: 24, top: 4, right: 4),
                        child: child,
                      ),
                    ),
                    const Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Navbar()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
