import 'package:flutter/material.dart';

class IconNavbar extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const IconNavbar({
    required this.icon,
    required this.onPressed,
    this.title = "",
    super.key,
  });

  @override
  State<IconNavbar> createState() => _IconNavbarState();
}

class _IconNavbarState extends State<IconNavbar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(icon: Icon(widget.icon), onPressed: widget.onPressed),
          ),
          widget.title != ""
              ? Positioned(
                  top: 8,
                  right: 4,
                  child: Container(
                    width: 20,
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
