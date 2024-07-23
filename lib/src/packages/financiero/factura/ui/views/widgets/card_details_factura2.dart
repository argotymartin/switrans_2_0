import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class CardDetailsFactura2 extends StatelessWidget {
  const CardDetailsFactura2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontWeight: FontWeight.w300,
      fontSize: 24,
    );
    final FormFacturaBloc facturaBloc = context.read<FormFacturaBloc>();
    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        final List<Documento> documentos = facturaBloc.state.documentos;
        final Iterable<ItemDocumento> itemDocumento = state.itemDocumentos.where((ItemDocumento element) => element.documento > 0);

        final double totalDocumentos = documentos.fold(0, (double total, Documento documento) => total + documento.rcp);
        final double totalImpuestos = itemDocumento.fold(0, (double total, ItemDocumento item) => total + item.valorIva);
        final double totalPrefacturas = itemDocumento.fold(0, (double total, ItemDocumento prefactura) => total + prefactura.total);
        final double valorFaltante = totalDocumentos - totalPrefacturas;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).colorScheme.onPrimaryContainer,
                Theme.of(context).colorScheme.primary,
              ],
            ),
            border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Cantidad Items:",
                      icon: Icons.file_copy_outlined,
                      content: Text("${itemDocumento.length}", style: textStyle),
                    ),
                    _BuildItemCard(
                      title: "Cantidad Documentos:",
                      icon: Icons.file_copy_outlined,
                      content: Text("${facturaBloc.state.documentos.length}", style: textStyle),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Total Documentos:",
                      icon: Icons.paid_outlined,
                      content:
                          FittedBox(child: CurrencyLabel(color: Colors.green.shade100, text: '${totalDocumentos.toInt()}', fontSize: 24)),
                    ),
                    _BuildItemCard(
                      title: "Valor Facturado:",
                      icon: Icons.price_check_outlined,
                      content: CurrencyLabel(color: Colors.blue.shade100, text: '${totalPrefacturas.toInt()}', fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Faltante:",
                      icon: Icons.money_off_outlined,
                      content: CurrencyLabel(color: Colors.red.shade100, text: '${valorFaltante.toInt()}', fontSize: 24),
                    ),
                    _BuildItemCard(
                      title: "Valor Impuesto:",
                      icon: Icons.currency_exchange_outlined,
                      content: CurrencyLabel(color: Colors.orange.shade100, text: '${totalImpuestos.toInt()}', fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildItemCard extends StatelessWidget {
  const _BuildItemCard({
    required this.title,
    required this.icon,
    required this.content,
  });

  final String title;
  final IconData icon;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    return SizedBox(
      width: 340,
      height: 32,
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(title, style: textStyle),
          const SizedBox(width: 4),
          content,
        ],
      ),
    );
  }
}
