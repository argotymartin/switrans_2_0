import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
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
  bool isEntered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        final bool isSelected = widget.paquete == state.paqueteMenu;
        final Color? colorSelected = context.read<ThemeCubit>().state.color;
        final List<ModulosSidebar> modulos = widget.paquete.modulos.map((ModuloMenu modulo) => ModulosSidebar(modulo: modulo)).toList();
        final ThemeState themeState = context.watch<ThemeCubit>().state;
        Color color;
        Color colorText;
        if (themeState.themeMode == 1) {
          color = isHovered || isEntered ? colorSelected!.withOpacity(0.6) : Colors.transparent;
          colorText = Theme.of(context).colorScheme.onPrimary;
        } else if (themeState.themeMode == 2) {
          color = isHovered || isEntered ? Colors.black.withOpacity(0.2) : Colors.transparent;
          colorText = Theme.of(context).colorScheme.primaryContainer;
        } else {
          color = isHovered || isEntered ? colorSelected!.withOpacity(0.05) : Colors.transparent;
          colorText = Colors.black;
        }
        return Material(
          color: color,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(
                    () {
                      isEntered = !isEntered;
                      if (!isSelected && !isEntered) {
                        isEntered = true;
                      }
                      context.read<MenuBloc>().add(SelectedPaqueteMenuEvent(widget.paquete));
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
                    color: color,
                    child: BuildOptionPaqueteMenu(
                      isMinimized: widget.isMimimize,
                      paquete: widget.paquete,
                      isHovered: isHovered,
                      color: color,
                      colorText: colorText,
                      isSelected: isSelected,
                      isEntered: isEntered,
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: widget.paquete == state.paqueteMenu && isEntered && !widget.isMimimize || widget.paquete.isSelected
                    ? Column(children: modulos)
                    : const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildOptionPaqueteMenu extends StatelessWidget {
  final PaqueteMenu paquete;
  final bool isMinimized;
  final bool isHovered;
  final bool isSelected;
  final bool isEntered;

  final Color color;
  final Color colorText;

  const BuildOptionPaqueteMenu({
    required this.paquete,
    required this.isMinimized,
    required this.isHovered,
    required this.isSelected,
    required this.isEntered,
    required this.color,
    required this.colorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: <Widget>[
          isSelected ? Container(width: 4, height: 48, color: Theme.of(context).colorScheme.primaryContainer) : const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  IconData(int.parse(paquete.icono), fontFamily: 'MaterialIcons'),
                  color: isHovered || isSelected ? colorText : colorText.withOpacity(0.6),
                  size: 20,
                ),
                isMinimized ? const SizedBox(width: 4) : const SizedBox(width: 10),
                isMinimized
                    ? SizedBox(
                        child: isSelected
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(100)),
                              )
                            : null,
                      )
                    : SizedBox(
                        width: 172,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          paquete.nombre,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: isHovered || isSelected ? FontWeight.w400 : FontWeight.w300,
                            color: isHovered || isSelected ? colorText : colorText.withOpacity(0.8),
                          ),
                        ),
                      ),
                isMinimized
                    ? const SizedBox()
                    : Icon(
                        isEntered ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down,
                        size: 16,
                        color: isHovered || isSelected ? colorText : colorText.withOpacity(0.6),
                      ),
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
    bodyBuilder: (BuildContext context) => SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
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
