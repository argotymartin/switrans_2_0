import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class PaginasSidebar extends StatefulWidget {
  final PaginaMenu pagina;
  const PaginasSidebar({
    required this.pagina,
    super.key,
  });

  @override
  State<PaginasSidebar> createState() => _PaginasSidebarState();
}

class _PaginasSidebarState extends State<PaginasSidebar> {
  bool isHovered = false;
  bool isEntered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeState state = context.watch<ThemeCubit>().state;
    final Color? colorSelected = context.watch<ThemeCubit>().state.color;

    Color color;
    Color colorText;
    if (state.themeMode == 1) {
      color = isHovered || widget.pagina.isSelected ? colorSelected!.withOpacity(0.3) : colorSelected!.withOpacity(0.4);
      colorText = Theme.of(context).colorScheme.onPrimary;
    } else if (state.themeMode == 2) {
      color = isHovered || widget.pagina.isSelected ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.4);
      colorText = Theme.of(context).colorScheme.primaryContainer;
    } else {
      color = isHovered || widget.pagina.isSelected ? colorSelected!.withOpacity(0.3) : colorSelected!.withOpacity(0.25);
      colorText = Colors.black;
    }
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () => setState(() {
          isEntered = !isEntered;
          final String path = context.read<MenuSidebarBloc>().onPaginaSelected(isSelected: isEntered, paginaMenu: widget.pagina);
          context.go(path);
        }),
        child: Material(
          color: color,
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 42.5),
                color: colorText,
                width: isHovered || widget.pagina.isSelected ? 2 : 1,
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(left: 43, top: 10, bottom: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: isHovered || widget.pagina.isSelected ? 2 : 1,
                      decoration: BoxDecoration(
                        color: colorText,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.pagina.texto,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: isHovered || widget.pagina.isSelected ? FontWeight.w400 : FontWeight.w300,
                        color: colorText,
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
                        : const SizedBox(),
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
