import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldPaquete extends StatelessWidget {
  final int? entryCodigoSelected;
  const FieldPaquete(this.entryCodigoSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    final ModuloBloc moduloBloc = context.read<ModuloBloc>();
    void onPressed(EntryAutocomplete entry) {
      moduloBloc.request.paquete = entry.codigo;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Paquete", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput2(
          entries: moduloBloc.state.entriesPaquete,
          entryCodigoSelected: entryCodigoSelected,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
