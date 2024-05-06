import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldPaquete extends StatelessWidget {
  final TextEditingController paqueteController;
  const FieldPaquete(this.paqueteController, {super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(EntryAutocomplete entry) {
      paqueteController.text = entry.codigo.toString();
    }

    final paquetes = context.read<ModuloBloc>().paquetes;
    final List<EntryAutocomplete> entryMenus = paquetes.map((e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Paquete", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          entries: entryMenus,
          label: "Paquete",
          onPressed: onPressed,
        ),
      ],
    );
  }
}
