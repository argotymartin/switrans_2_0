import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/paquete_menu/paquete_menu_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class PaginasSidebar extends StatefulWidget {
  final PaginaMenu pagina;
  const PaginasSidebar({super.key, required this.pagina});

  @override
  State<PaginasSidebar> createState() => _PaginasSidebarState();
}

class _PaginasSidebarState extends State<PaginasSidebar> {
  bool isHovered = false;
  bool isEntered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () => setState(() {
          isEntered = !isEntered;
          final path = context.read<PaqueteMenuBloc>().onPaginaSelected(widget.pagina, isEntered);
          context.go(path);
        }),
        child: Material(
          color: isHovered || widget.pagina.isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5)
              : Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.4),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 42.5),
                color: Theme.of(context).colorScheme.primaryContainer,
                width: isHovered || widget.pagina.isSelected ? 2 : 1,
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(left: 43, top: 10, bottom: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: isHovered || widget.pagina.isSelected ? 2 : 1,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.pagina.texto,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: isHovered || widget.pagina.isSelected ? FontWeight.w400 : FontWeight.w200,
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
