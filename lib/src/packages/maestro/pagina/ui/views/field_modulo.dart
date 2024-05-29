import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldModulo extends StatelessWidget {
  final TextEditingController moduloController;
  const FieldModulo(this.moduloController, {super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(EntryAutocomplete entry) {
      moduloController.text = entry.codigo.toString();
    }
    final List<PaginaModulo> modulos = context.read<PaginaBloc>().modulos;
    final List<EntryAutocomplete> entryMenus =
    modulos.map((PaginaModulo p) => EntryAutocomplete(title: p.nombre, codigo: p.codigo)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Modulo", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          //controller: moduloController,
          entries: entryMenus,
          label: "Modulo",
          onPressed: onPressed,
        ),
      ],
    );
  }
}
