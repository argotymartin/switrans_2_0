import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/navbar.dart';
import 'package:switrans_2_0/src/modules/shared/sidebar.dart';

class MenuLayout extends StatefulWidget {
  final Widget child;
  const MenuLayout({super.key, required this.child});

  @override
  State<MenuLayout> createState() => _MenuLayoutState();
}

class _MenuLayoutState extends State<MenuLayout> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0ffefff2),
      body: Stack(
        children: [
          Row(
            children: [
              const Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    const Navbar(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
