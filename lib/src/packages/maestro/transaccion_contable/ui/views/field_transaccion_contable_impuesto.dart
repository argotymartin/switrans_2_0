import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/autocomplete_input.dart';

class FieldTransaccionContableImpuesto extends StatelessWidget {
  final TextEditingController impuestoController;
  const FieldTransaccionContableImpuesto(this.impuestoController, {super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(EntryAutocomplete entry) {
      impuestoController.text = entry.codigo.toString();
    }

    final List<TransaccionContableTipoImpuesto> impuestos = context.read<TransaccionContableBloc>().listImpuestos;
    final List<EntryAutocomplete> entryMenus = impuestos.map((TransaccionContableTipoImpuesto e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Impuesto", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          entries: entryMenus,
          label: "Impuesto",
          onPressed: onPressed,
        ),
      ],
    );
  }
}
