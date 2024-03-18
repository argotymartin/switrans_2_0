import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/paginas_sidebar.dart';

class ModulosSidebar extends StatefulWidget {
  final PaqueteMenu paquete;
  final ModuloMenu modulo;
  const ModulosSidebar({super.key, required this.paquete, required this.modulo});

  @override
  State<ModulosSidebar> createState() => _ModulosSidebarState();
}

class _ModulosSidebarState extends State<ModulosSidebar> {
  bool isHovered = false;
  bool isEntered = false;
  @override
  Widget build(BuildContext context) {
    final paginas =
        widget.modulo.paginas.map((item) => PaginasSidebar(pagina: item, modulo: widget.modulo, paquete: widget.paquete)).toList();
    return Column(
      children: [
        Material(
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
          child: InkWell(
            onTap: () => setState(() {
              isEntered = !isEntered;
            }),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Container(
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black26))),
                child: Container(
                  margin: EdgeInsets.only(left: isHovered ? 40 : 40.5, top: 10, bottom: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: isHovered ? 10 : 8,
                        height: isHovered ? 10 : 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.modulo.texto,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: isHovered ? FontWeight.w400 : FontWeight.w200,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        isEntered ? Icons.menu_open_outlined : Icons.menu_outlined,
                        size: 16,
                        color: isHovered || isEntered
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.onTertiary.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 18,
                        child: widget.modulo.isSelected
                            ? Center(
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              )
                            : null,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isEntered ? Column(children: paginas) : const SizedBox()
      ],
    );
  }
}
