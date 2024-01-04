import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/menu/menu_bloc.dart';

class MenuButtonNavar extends StatefulWidget {
  const MenuButtonNavar({
    super.key,
  });

  @override
  State<MenuButtonNavar> createState() => _MenuButtonNavarState();
}

class _MenuButtonNavarState extends State<MenuButtonNavar> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    bool isOpenMenu = context.read<MenuBloc>().state.isOpenMenu;
    bool isOpenMenuIcon = context.read<MenuBloc>().state.isOpenMenuIcon;
    return MouseRegion(
      onEnter: (event) => setState(() => isHover = true),
      onExit: (event) => setState(() => isHover = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: isHover ? Colors.grey.shade400 : Colors.transparent),
        ),
        child: Column(
          children: [
            _BuildButton(
              icon: Icons.menu_outlined,
              onPressed: () {
                context.read<MenuBloc>().add(ActiveteMenuEvent(isOpenMenu: !isOpenMenu, isOpenMenuIcon: isOpenMenuIcon));
              },
            ),
            _BuildButton(
              icon: Icons.menu_open_outlined,
              isHover: isHover,
              onPressed: () {
                context.read<MenuBloc>().add(ActiveteMenuEvent(isOpenMenu: isOpenMenu, isOpenMenuIcon: !isOpenMenuIcon));
              },
            ),
            _BuildButton(icon: Icons.lock_outlined, isHover: isHover, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _BuildButton extends StatefulWidget {
  final IconData icon;
  final bool isHover;
  final Function onPressed;

  const _BuildButton({required this.icon, this.isHover = true, required this.onPressed});

  @override
  State<_BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<_BuildButton> {
  bool isHover = false;
  bool isSeleted = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => isHover = true),
      onExit: (event) => setState(() => isHover = false),
      child: widget.isHover
          ? Container(
              height: 40,
              width: 54,
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSeleted
                    ? Colors.black87
                    : isHover
                        ? Colors.indigo
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: IconButton(
                color: isHover ? Colors.white : Colors.grey.shade400,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() => isSeleted = !isSeleted);
                  //SideMenuProvider.toggleMenu();
                  widget.onPressed();
                },
                icon: Icon(widget.icon),
              ),
            )
          : const SizedBox(),
    );
  }
}
