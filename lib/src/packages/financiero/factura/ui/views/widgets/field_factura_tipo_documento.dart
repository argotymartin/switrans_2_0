import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldFacturaTipoDocumento extends StatelessWidget {
  const FieldFacturaTipoDocumento({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TipoDocumento> tiposDocumentos = context.read<FormFacturaBloc>().state.tiposDocumentos;
    final TextEditingController controller = TextEditingController();
    void onPressed(EntryAutocomplete entry) {
      //context.read<FormFacturaBloc>().add(TipoFacturaFormFacturaEvent(entry.codigo));
    }

    final List<EntryAutocomplete> entries = tiposDocumentos.map((TipoDocumento tipoDocumento) {
      return EntryAutocomplete(
        title: tipoDocumento.nombre,
        codigo: tipoDocumento.codigo,
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipo Documento", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          controller: controller,
          label: "Tipo",
          entryCodigoSelected: 1,
          entries: entries,
          onPressed: onPressed,
          minChractersSearch: 0,
        ),
      ],
    );
  }
}
