import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final ModuloBloc moduloBloc = context.read<ModuloBloc>();
    final modulo = moduloBloc.state.modulos.firstWhere((element) => element.isSelected);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadcrumbTrail(elements: breadcrumbTrails),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(IconData(int.parse(modulo.icono), fontFamily: 'MaterialIcons'), color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(modulo.texto, style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
        Text(modulo.detalles, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
