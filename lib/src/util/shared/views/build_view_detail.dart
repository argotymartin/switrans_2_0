import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class BuildViewDetail extends StatelessWidget {
  const BuildViewDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final List<String> breadcrumbTrails = fullPath.split("/");
    final MenuSidebarBloc menuBloc = context.read<MenuSidebarBloc>();
    final Size size = MediaQuery.of(context).size;
    ModuloMenu? moduloSelected;
    for (final PaqueteMenu paquete in menuBloc.state.paquetes) {
      for (final ModuloMenu modulo in paquete.modulos) {
        if (modulo.path.contains(breadcrumbTrails[2])) {
          moduloSelected = modulo;
        }
      }
    }
    return moduloSelected != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BreadcrumbTrail(elements: breadcrumbTrails),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    IconData(int.parse(moduloSelected.icono), fontFamily: 'MaterialIcons'),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: size.width * 0.4,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(moduloSelected.texto, style: const TextStyle(fontSize: 28)),
                    ),
                  ),
                ],
              ),
              Text(moduloSelected.detalles, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
            ],
          )
        : const SizedBox();
  }
}
