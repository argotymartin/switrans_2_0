import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldTipoDocumento extends StatelessWidget {
  const FieldTipoDocumento({super.key});

  @override
  Widget build(BuildContext context) {
    final AccionDocumentoBloc accionDocumentoBloc = context.read<AccionDocumentoBloc>();
    final TextEditingController typeController = TextEditingController();

    void onPressed(EntryAutocomplete entry) {
      accionDocumentoBloc.request.tipoDocumento = entry.codigo;
    }

    final List<TipoDocumentoAccionDocumento> acciones = accionDocumentoBloc.tipos;
    final List<EntryAutocomplete> entryMenus = acciones
        .map(
          (TipoDocumentoAccionDocumento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipo Documento", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          controller: typeController,
          entries: entryMenus,
          label: "Tipo Documento",
          onPressed: onPressed,
        ),
      ],
    );
  }
}
