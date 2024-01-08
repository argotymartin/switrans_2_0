import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/widgets/navbar/navbar.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/widgets/sidebar/sidebar.dart';

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
    context.read<ModuloBloc>().add(const ActiveteModuloEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0x0ffefff2),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: widget.child,
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
