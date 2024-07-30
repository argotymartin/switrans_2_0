import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FieldFacturaCliente extends StatelessWidget {
  const FieldFacturaCliente({super.key});

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc facturaFilterBloc = BlocProvider.of<FormFacturaBloc>(context);
    final List<Cliente> clientes = facturaFilterBloc.state.clientes;
    final Cliente? cliente = clientes.firstWhereOrNull((Cliente element) => element.codigo == facturaFilterBloc.clienteCodigo);
    final TextEditingController controller = TextEditingController();
    if (cliente != null) {
      controller.text = cliente.nombre;
    }

    void setValueCliente(EntryAutocomplete entry) {
      facturaFilterBloc.clienteCodigo = entry.codigo!;
      controller.text = entry.title;
    }

    final List<EntryAutocomplete> entries = clientes.map((Cliente cliente) {
      return EntryAutocomplete(
        title: cliente.nombre,
        subTitle: cliente.identificacion,
        codigo: cliente.codigo,
        details: Row(
          children: <Widget>[
            const Icon(Icons.call, size: 16),
            Text(cliente.telefono, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w100)),
          ],
        ),
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Cliente", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          label: "Cliente",
          entries: entries,
          onPressed: setValueCliente,
          controller: controller,
          minChractersSearch: 3,
        ),
      ],
    );
  }
}
