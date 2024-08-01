import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/autocomplete_input2.dart';

class FieldTipoDocumento extends StatelessWidget {
  final int? entryCodigoSelected;
  const FieldTipoDocumento({super.key, this.entryCodigoSelected});

  @override
  Widget build(BuildContext context) {
    final AccionDocumentoBloc accionDocumentoBloc = context.watch<AccionDocumentoBloc>();

    void onPressed(EntryAutocomplete entry) {
      accionDocumentoBloc.request.tipoDocumento = entry.codigo;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipo Documento", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput2(
          entryCodigoSelected: entryCodigoSelected,
          entries: accionDocumentoBloc.state.entriesTiposDocumento,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
