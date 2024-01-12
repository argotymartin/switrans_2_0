import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:switrans_2_0/src/modules/menu/domain/entities/modulo.dart';

class MenuItemSidebar extends StatefulWidget {
  final Modulo modulo;
  final Function onPressed;
  final bool isMimimize;

  const MenuItemSidebar({
    required this.modulo,
    required this.onPressed,
    this.isMimimize = false,
    super.key,
  });

  @override
  State<MenuItemSidebar> createState() => _MenuItemSidebarState();
}

class _MenuItemSidebarState extends State<MenuItemSidebar> {
  bool isHovered = false;
  bool isEnter = false;
  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final isActive = location == widget.modulo.moduloPath;
    final paginas = widget.modulo.paginas.map((item) => SubMenuItemSidebar(text: item.paginaTexto)).toList();
    return AnimatedContainer(
      duration: const Duration(microseconds: 250),
      color: isHovered
          ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.2)
          : isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.2)
              : Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 46,
            child: Row(
              children: [
                isActive
                    ? Container(width: 4, height: 48, color: Theme.of(context).colorScheme.primaryContainer)
                    : const SizedBox(width: 4),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => setState(() {
                      isEnter = !isEnter;
                      widget.onPressed();
                      widget.isMimimize
                          ? showPopover(
                              context: context,
                              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                              direction: PopoverDirection.right,
                              width: 250,
                              height: (paginas.length * 42) + 32,
                              arrowWidth: 60,
                              bodyBuilder: (context) => Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.modulo.moduloTexto,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Column(children: paginas),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null;
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: MouseRegion(
                        onHover: (_) => setState(() => isHovered = true),
                        onExit: (_) => setState(() => isHovered = false),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              IconData(int.parse(widget.modulo.moduloIcono), fontFamily: 'MaterialIcons'),
                              color: isHovered || isEnter
                                  ? Theme.of(context).colorScheme.onTertiary
                                  : Theme.of(context).colorScheme.onTertiary.withOpacity(0.6),
                              size: 20,
                            ),
                            widget.isMimimize ? const SizedBox(width: 4) : const SizedBox(width: 10),
                            widget.isMimimize
                                ? SizedBox(
                                    child: isActive
                                        ? Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(100)),
                                          )
                                        : null)
                                : SizedBox(
                                    width: 172,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      widget.modulo.moduloTexto,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: isHovered || isEnter ? FontWeight.w400 : FontWeight.w300,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                            widget.isMimimize
                                ? const SizedBox()
                                : Icon(
                                    isEnter ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: isHovered || isEnter
                                        ? Theme.of(context).colorScheme.onTertiary
                                        : Theme.of(context).colorScheme.onTertiary.withOpacity(0.6),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //isEnter & widget.isActive
          isEnter & !widget.isMimimize ? Column(children: paginas) : const SizedBox()
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
      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      child: InkWell(
        onTap: () => setState(() {
          isSelected = !isSelected;
        }),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onHover: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 33),
                color: Theme.of(context).colorScheme.primaryContainer,
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
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.text,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: isHovered ? FontWeight.w400 : FontWeight.w200,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    const Spacer(),
                    isSelected
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
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
