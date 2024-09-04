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
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        final ThemeState themeState = context.watch<ThemeCubit>().state;
        final Color? colorSelected = context.watch<ThemeCubit>().state.color;

        final bool isSelected = state.paginaMenu == widget.pagina;

        Color color;
        Color colorText;
        if (themeState.themeMode == 1) {
          color = isHovered || isSelected ? colorSelected!.withOpacity(0.3) : colorSelected!.withOpacity(0.4);
          colorText = Theme.of(context).colorScheme.onPrimary;
        } else if (themeState.themeMode == 2) {
          color = isHovered || isSelected ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.4);
          colorText = Theme.of(context).colorScheme.primaryContainer;
        } else {
          color = isHovered || isSelected ? colorSelected!.withOpacity(0.3) : colorSelected!.withOpacity(0.25);
          colorText = Colors.black;
        }
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: InkWell(
            onTap: () => setState(() {
              final MenuBloc menuBloc = context.read<MenuBloc>();
              isEntered = !isEntered;
              final String path = "${state.paqueteMenu!.path}${state.moduloMenu!.path}${widget.pagina.path}";
              menuBloc.add(SelectedPaginaMenuEvent(widget.pagina));

              context.go(path);
            }),
            child: Material(
              color: color,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 42.5),
                    color: colorText,
                    width: isHovered || isSelected ? 2 : 1,
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 43, top: 10, bottom: 10, right: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: isHovered || isSelected ? 2 : 1,
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
                            fontWeight: isHovered || isSelected ? FontWeight.w400 : FontWeight.w300,
                            color: colorText,
                          ),
                        ),
                        const Spacer(),
                        isSelected
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF39FF14),
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
      },
    );
  }
}
