import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/modulos_sidebar.dart';

class PaquetesSidebar extends StatefulWidget {
  final Paquete paquete;
  final bool isMimimize;
  final Function onPressed;

  const PaquetesSidebar({
    required this.paquete,
    this.isMimimize = false,
    super.key,
    required this.onPressed,
  });

  @override
  State<PaquetesSidebar> createState() => _PaquetesSidebarState();
}

class _PaquetesSidebarState extends State<PaquetesSidebar> {
  bool isHovered = false;
  bool isEntered = false;
  @override
  Widget build(BuildContext context) {
    final modulos = widget.paquete.modulos.map((item) => ModulosSidebar(modulo: item, paquete: widget.paquete)).toList();
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(microseconds: 250),
      color: isHovered || widget.paquete.isSelected ? colorScheme.onPrimaryContainer.withOpacity(0.2) : Colors.transparent,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.onPressed();
                  isEntered = !isEntered;
                  widget.isMimimize ? showPopoverImpl(context, modulos, widget.paquete) : null;
                });
              },
              child: MouseRegion(
                onHover: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: BuildOptionModuloMenu(
                  isEntered: isEntered,
                  isMinimized: widget.isMimimize,
                  paquete: widget.paquete,
                  isHovered: isHovered,
                ),
              ),
            ),
          ),
          isEntered & !widget.isMimimize ? Column(children: modulos) : const SizedBox()
        ],
      ),
    );
  }
}

class BuildOptionModuloMenu extends StatelessWidget {
  final Paquete paquete;
  final bool isMinimized;
  final bool isEntered;
  final bool isHovered;

  const BuildOptionModuloMenu({
    super.key,
    required this.paquete,
    required this.isMinimized,
    required this.isEntered,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 46,
      child: Row(
        children: [
          paquete.isSelected ? Container(width: 4, height: 48, color: colorScheme.primaryContainer) : const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconData(int.parse(paquete.icono), fontFamily: 'MaterialIcons'),
                  color: isHovered || isEntered ? colorScheme.onTertiary : colorScheme.onTertiary.withOpacity(0.6),
                  size: 20,
                ),
                isMinimized ? const SizedBox(width: 4) : const SizedBox(width: 10),
                isMinimized
                    ? SizedBox(
                        child: paquete.isSelected
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
                          paquete.nombre,
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

Future<Object?> showPopoverImpl(BuildContext context, List<ModulosSidebar> modulo, Paquete paquete) {
  return showPopover(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    direction: PopoverDirection.right,
    constraints: BoxConstraints.loose(const Size.fromWidth(250)),
    arrowWidth: 60,
    bodyBuilder: (context) => SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  paquete.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Column(children: modulo),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
