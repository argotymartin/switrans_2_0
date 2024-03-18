import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class PaginasSidebar extends StatefulWidget {
  final PaginaMenu pagina;
  final ModuloMenu modulo;
  final PaqueteMenu paquete;
  const PaginasSidebar({super.key, required this.pagina, required this.modulo, required this.paquete});

  @override
  State<PaginasSidebar> createState() => _PaginasSidebarState();
}

class _PaginasSidebarState extends State<PaginasSidebar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
      child: InkWell(
        onTap: () => setState(() {
          context.read<PaquetesMenuBloc>().add(ChangedModuloEvent(widget.paquete, widget.modulo, widget.pagina));
          final path = "${widget.paquete.path}${widget.modulo.path}${widget.pagina.path}";
          context.go(path);
        }),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 42.5),
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 1,
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(left: 42.5, top: 10, bottom: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: isHovered ? 4 : 2,
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
