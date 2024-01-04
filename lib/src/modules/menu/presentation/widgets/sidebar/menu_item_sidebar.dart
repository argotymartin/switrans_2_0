import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemSidebar extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final bool isMenuIcon;
  final Function onPressed;
  const MenuItemSidebar({
    super.key,
    this.text = '',
    required this.icon,
    this.isActive = false,
    this.isMenuIcon = false,
    required this.onPressed,
  });

  @override
  State<MenuItemSidebar> createState() => _MenuItemSidebarState();
}

class _MenuItemSidebarState extends State<MenuItemSidebar> {
  bool isHovered = false;
  bool isEnter = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 250),
      color: isHovered
          ? Colors.white.withOpacity(0.1)
          : widget.isActive
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              widget.isActive ? Container(width: 4, height: 40, color: Colors.indigo.shade300) : const SizedBox(width: 4),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() {
                    isEnter = !isEnter;
                    widget.onPressed();
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: MouseRegion(
                      onHover: (_) => setState(() => isHovered = true),
                      onExit: (_) => setState(() => isHovered = false),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            widget.icon,
                            color: isHovered || isEnter ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.3),
                            size: 20,
                          ),
                          widget.isMenuIcon ? const SizedBox() : const SizedBox(width: 10),
                          widget.isMenuIcon
                              ? const SizedBox()
                              : SizedBox(
                                  width: 172,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    widget.text,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: isHovered || isEnter ? FontWeight.w400 : FontWeight.w300,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                          widget.isMenuIcon
                              ? const SizedBox()
                              : Icon(
                                  isEnter ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: isHovered || isEnter ? Colors.white : Colors.white.withOpacity(0.3),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //isEnter & widget.isActive
          isEnter
              ? const Column(
                  children: [
                    SubMenuItemSidebar(text: 'Analitics Dasboard'),
                    SubMenuItemSidebar(text: 'Marketing Dasboard'),
                    SubMenuItemSidebar(text: 'Introduction'),
                    SubMenuItemSidebar(text: 'Privacity'),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class SubMenuItemSidebar extends StatefulWidget {
  final String text;
  const SubMenuItemSidebar({super.key, required this.text});

  @override
  State<SubMenuItemSidebar> createState() => _SubMenuItemSidebarState();
}

class _SubMenuItemSidebarState extends State<SubMenuItemSidebar> {
  bool isHovered = false;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff284d80),
      child: InkWell(
        onTap: () => setState(() => isSelected = !isSelected),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onHover: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 33,
                ),
                color: Colors.grey,
                width: 1,
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: isHovered ? 30 : 30.5, top: 10, bottom: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      width: isHovered ? 8 : 6,
                      height: isHovered ? 8 : 6,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.text,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: isHovered ? FontWeight.w400 : FontWeight.w200,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const Spacer(),
                    isSelected
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                        : const SizedBox()
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
