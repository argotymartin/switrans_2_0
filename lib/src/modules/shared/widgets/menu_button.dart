import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
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
            _BuildButton(icon: Icons.menu_outlined, onPressed: () {}),
            _BuildButton(icon: Icons.menu_open_outlined, isHover: isHover, onPressed: () {}),
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
