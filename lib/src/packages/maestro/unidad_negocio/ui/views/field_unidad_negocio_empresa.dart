import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/entry_autocomplete.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/autocomplete_input.dart';

class FieldUnidadNegocioEmpresa extends StatelessWidget {
  final TextEditingController empresaController;
  const FieldUnidadNegocioEmpresa(this.empresaController, {super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(EntryAutocomplete entry) {
      empresaController.text = entry.codigo.toString();
    }

    final empresas = context.read<UnidadNegocioBloc>().empresas;
    final List<EntryAutocomplete> entryMenus = empresas.map((e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Empresa", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          entries: entryMenus,
          label: "Empresa",
          onPressed: onPressed,
        ),
      ],
    );
  }
}
