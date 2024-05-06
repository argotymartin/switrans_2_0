import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/menu_sidebar/menu_sidebar_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/modulos_sidebar.dart';

class PaquetesSidebar extends StatefulWidget {
  final PaqueteMenu paquete;
  final bool isMimimize;

  const PaquetesSidebar({
    required this.paquete,
    this.isMimimize = false,
    super.key,
  });

  @override
  State<PaquetesSidebar> createState() => _PaquetesSidebarState();
}

class _PaquetesSidebarState extends State<PaquetesSidebar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isEntered = widget.paquete.isSelected;
    final colorScheme = Theme.of(context).colorScheme;
    List<ModulosSidebar> modulos = widget.paquete.modulos.map((modulo) => ModulosSidebar(modulo: modulo)).toList();
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(
              () {
                isEntered = !isEntered;
                context.read<MenuSidebarBloc>().onPaqueteSelected(isSelected: isEntered, paqueteMenu: widget.paquete);
                if (widget.isMimimize) {
                  showPopoverImpl(context, modulos, widget.paquete);
                }
              },
            );
          },
          child: MouseRegion(
            onHover: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Material(
              color: isHovered || widget.paquete.isSelected ? colorScheme.onPrimaryContainer.withOpacity(0.1) : Colors.transparent,
              child: BuildOptionPaqueteMenu(
                isMinimized: widget.isMimimize,
                paquete: widget.paquete,
                isHovered: isHovered,
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: widget.paquete.isSelected & !widget.isMimimize ? Column(children: modulos) : const SizedBox(),
        ),
      ],
    );
  }
}

class BuildOptionPaqueteMenu extends StatelessWidget {
  final PaqueteMenu paquete;
  final bool isMinimized;
  final bool isHovered;

  const BuildOptionPaqueteMenu({
    required this.paquete,
    required this.isMinimized,
    required this.isHovered,
    super.key,
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
                  color: isHovered || paquete.isSelected ? colorScheme.onTertiary : colorScheme.onTertiary.withOpacity(0.6),
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
                            fontWeight: isHovered || paquete.isSelected ? FontWeight.w400 : FontWeight.w300,
                            color: isHovered || paquete.isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                isMinimized
                    ? const SizedBox()
                    : Icon(
                        paquete.isSelected ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down,
                        size: 16,
                        color: isHovered || paquete.isSelected
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

Future<Object?> showPopoverImpl(BuildContext context, List<ModulosSidebar> modulo, PaqueteMenu paquete) {
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
