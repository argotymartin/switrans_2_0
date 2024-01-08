import 'package:flutter/material.dart';

class IconNavbar extends StatefulWidget {
  final IconData icon;
  final String title;
  const IconNavbar({
    Key? key,
    required this.icon,
    this.title = "",
  }) : super(key: key);

  @override
  State<IconNavbar> createState() => _IconNavbarState();
}

class _IconNavbarState extends State<IconNavbar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 38,
      child: Stack(
        children: [
          Positioned(
            top: 6,
            left: 6,
            child: MouseRegion(
              onHover: (event) => setState(() => isHovered = true),
              onExit: (event) => setState(() => isHovered = false),
              child: Icon(widget.icon, color: isHovered ? Colors.indigo : Colors.indigo.withOpacity(0.6), size: 28),
            ),
          ),
          widget.title != ""
              ? Positioned(
                  top: 4,
                  right: 2,
                  child: Container(
                    width: 18,
                    height: 14,
                    decoration: bulidBoxDecoration(),
                    child: Center(child: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 10))),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  BoxDecoration bulidBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(100),
      );
}
