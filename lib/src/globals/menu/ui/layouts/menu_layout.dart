import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class MenuLayout extends StatelessWidget {
  final Widget child;
  const MenuLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0xffedf2f9),
        body: Row(
          children: [
            const Sidebar(),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
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
            )
          ],
        ),
      ),
    );
  }
}
