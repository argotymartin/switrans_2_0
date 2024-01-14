import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';

import 'package:switrans_2_0/src/modules/menu/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/modules/menu/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';

class MenuItemSidebar extends StatefulWidget {
  final Modulo modulo;
  final bool isMimimize;

  const MenuItemSidebar({
    required this.modulo,
    this.isMimimize = false,
    super.key,
  });

  @override
  State<MenuItemSidebar> createState() => _MenuItemSidebarState();
}

class _MenuItemSidebarState extends State<MenuItemSidebar> {
  bool isHovered = false;
  bool isEntered = false;
  @override
  Widget build(BuildContext context) {
    final paginas2 = widget.modulo.paginas;
    final paginas = widget.modulo.paginas.map((item) => SubMenuItemSidebar(pagina: item, modulo: widget.modulo)).toList();
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(microseconds: 250),
      color: isHovered || widget.modulo.isSelected ? colorScheme.onPrimaryContainer.withOpacity(0.2) : Colors.transparent,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  isEntered = !isEntered;
                  widget.isMimimize ? showPopoverImpl(context, paginas, widget.modulo) : null;
                });
              },
              child: MouseRegion(
                onHover: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: BuildOptionModuloMenu(
                  isEntered: isEntered,
                  isMinimized: widget.isMimimize,
                  modulo: widget.modulo,
                  paginas: paginas,
                  isHovered: isHovered,
                ),
              ),
            ),
          ),
          isEntered & !widget.isMimimize ? Column(children: paginas) : const SizedBox()
        ],
      ),
    );
  }
}

class BuildOptionModuloMenu extends StatelessWidget {
  final Modulo modulo;
  final List<SubMenuItemSidebar> paginas;
  final bool isMinimized;
  final bool isEntered;
  final bool isHovered;

  const BuildOptionModuloMenu({
    Key? key,
    required this.modulo,
    required this.paginas,
    required this.isMinimized,
    required this.isEntered,
    required this.isHovered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 46,
      child: Row(
        children: [
          modulo.isSelected ? Container(width: 4, height: 48, color: colorScheme.primaryContainer) : const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconData(int.parse(modulo.moduloIcono), fontFamily: 'MaterialIcons'),
                  color: isHovered || isEntered ? colorScheme.onTertiary : colorScheme.onTertiary.withOpacity(0.6),
                  size: 20,
                ),
                isMinimized ? const SizedBox(width: 4) : const SizedBox(width: 10),
                isMinimized
                    ? SizedBox(
                        child: modulo.isSelected
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
                          modulo.moduloTexto,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: isHovered || isEntered ? FontWeight.w400 : FontWeight.w300,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                isMinimized
                    ? const SizedBox()
                    : Icon(
                        isEntered ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down,
                        size: 16,
                        color: isHovered || isEntered
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.onTertiary.withOpacity(0.6),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubMenuItemSidebar extends StatefulWidget {
  final Pagina pagina;
  final Modulo modulo;
  const SubMenuItemSidebar({super.key, required this.pagina, required this.modulo});

  @override
  State<SubMenuItemSidebar> createState() => _SubMenuItemSidebarState();
}

class _SubMenuItemSidebarState extends State<SubMenuItemSidebar> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      child: InkWell(
        onTap: () => setState(() {
          context.read<ModuloBloc>().add(ChangedModuloEvent(widget.modulo, widget.pagina));
        }),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
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
                      widget.pagina.paginaTexto,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: isHovered ? FontWeight.w400 : FontWeight.w200,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    const Spacer(),
                    widget.pagina.isSelected
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

Future<Object?> showPopoverImpl(BuildContext context, List<SubMenuItemSidebar> paginas, Modulo modulo) {
  return showPopover(
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
                modulo.moduloTexto,
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
  );
}
