import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class BuildViewDetail extends StatelessWidget {
  final String path;
  const BuildViewDetail({
    super.key,
    this.path = "",
  });

  @override
  Widget build(BuildContext context) {
    List<String> breadcrumbTrails = path.split("/");
    final MenuSidebarBloc menuBloc = context.read<MenuSidebarBloc>();
    late ModuloMenu moduloSelected;
    for (final paquete in menuBloc.state.paquetes) {
      for (final modulo in paquete.modulos) {
        if (modulo.path.contains(breadcrumbTrails[2])) {
          moduloSelected = modulo;
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadcrumbTrail(elements: breadcrumbTrails),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(IconData(int.parse(moduloSelected.icono), fontFamily: 'MaterialIcons'), color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(moduloSelected.texto, style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
        Text(moduloSelected.detalles, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
