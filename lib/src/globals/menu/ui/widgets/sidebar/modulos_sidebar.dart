import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/paginas_sidebar.dart';

class ModulosSidebar extends StatefulWidget {
  final ModuloMenu modulo;
  const ModulosSidebar({
    required this.modulo,
    super.key,
  });

  @override
  State<ModulosSidebar> createState() => _ModulosSidebarState();
}

class _ModulosSidebarState extends State<ModulosSidebar> {
  bool isHovered = false;
  bool isEntered = false;
  @override
  Widget build(BuildContext context) {
    final List<PaginasSidebar> paginas = widget.modulo.paginas.map((PaginaMenu pagina) => PaginasSidebar(pagina: pagina)).toList();
    final Color? colorSelected = context.watch<ThemeCubit>().state.color;

    Color color;
    Color colorText;
    final ThemeState state = context.watch<ThemeCubit>().state;
    if (state.themeMode == 1) {
      color = isHovered || widget.modulo.isSelected ? colorSelected!.withOpacity(0.3) : colorSelected!.withOpacity(0.1);
      colorText = Theme.of(context).colorScheme.primaryContainer;
    } else if (state.themeMode == 2) {
      color = isHovered || widget.modulo.isSelected ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.2);
      colorText = Theme.of(context).colorScheme.primaryContainer;
    } else {
      color = color = isHovered || widget.modulo.isSelected ? colorSelected!.withOpacity(0.2) : colorSelected!.withOpacity(0.1);
      colorText = Colors.black;
    }
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => setState(() {
            isEntered = !isEntered;
            context.read<MenuSidebarBloc>().onModuloSelected(isSelected: isEntered, moduloMenu: widget.modulo);
          }),
          child: MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Material(
              color: color,
              child: DecoratedBox(
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black26))),
                child: Container(
                  margin: EdgeInsets.only(left: isHovered ? 40 : 40.5, top: 10, bottom: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: isHovered || widget.modulo.isSelected ? 10 : 8,
                        height: isHovered || widget.modulo.isSelected ? 10 : 8,
                        decoration: BoxDecoration(
                          color: colorText,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.modulo.texto,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: isHovered || widget.modulo.isSelected ? FontWeight.w400 : FontWeight.w300,
                          color: colorText,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        widget.modulo.isSelected ? Icons.arrow_left : Icons.arrow_right,
                        size: 16,
                        color: isHovered || widget.modulo.isSelected || widget.modulo.isSelected ? colorText : colorText.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 18,
                        child: widget.modulo.isSelected
                            ? Center(
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.modulo.isSelected ? Column(children: paginas) : const SizedBox(),
        ),
      ],
    );
  }
}
