import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class CardDetailsFactura extends StatelessWidget {
  const CardDetailsFactura({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400, fontSize: 14);
    return BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
      builder: (context, state) {
        final FacturaBloc facturaBloc = context.read<FacturaBloc>();
        final documentos = facturaBloc.state.documentos;
        final prefacturas = state.preFacturas;

        int totalDocumentos = documentos.fold(0, (total, documento) => total + documento.rcp);
        int totalPrefacturas = prefacturas.fold(0, (total, prefactura) => total + prefactura.total);
        int valorFaltante = totalDocumentos - totalPrefacturas;

        return Container(
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
            boxShadow: [
              BoxShadow(color: Theme.of(context).colorScheme.primary, offset: const Offset(-8, 0)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.file_copy_outlined),
                  const SizedBox(width: 8),
                  Text("Cantidad Items: ${state.preFacturas.length}", style: textStyle),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.text_snippet_outlined),
                  const SizedBox(width: 8),
                  Text("Cantidad Documentos ${facturaBloc.state.documentos.length}", style: textStyle),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.price_check_outlined),
                  const SizedBox(width: 8),
                  Text("Valor Facturado: ", style: textStyle),
                  CurrencyLabel(color: Colors.blue, text: '$totalPrefacturas'),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.paid_outlined),
                  const SizedBox(width: 8),
                  Text("Valor Total Documentos: ", style: textStyle),
                  CurrencyLabel(color: Colors.green, text: '$totalDocumentos'),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.money_off_outlined),
                  const SizedBox(width: 8),
                  Text("Valor Faltante: ", style: textStyle),
                  CurrencyLabel(color: Colors.red, text: '$valorFaltante'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
