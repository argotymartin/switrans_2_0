import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldModulo extends StatelessWidget {
  final int? entryCodigoSelected;
  const FieldModulo(this.entryCodigoSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    final PaginaBloc paginaBloc = context.read<PaginaBloc>();
    void onPressed(EntryAutocomplete entry) {
      paginaBloc.request.modulo = entry.codigo;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Modulo", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput2(
          entries: paginaBloc.state.entriesModulos,
          entryCodigoSelected: entryCodigoSelected,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
