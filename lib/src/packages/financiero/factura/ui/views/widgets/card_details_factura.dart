import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class CardDetailsFactura extends StatelessWidget {
  const CardDetailsFactura({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DocumentoBloc facturaBloc = context.read<DocumentoBloc>();
    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        final List<Documento> documentos = facturaBloc.state.documentos;
        final Iterable<ItemDocumento> itemDocumento = state.itemDocumentos.where((ItemDocumento element) => element.tipo.isNotEmpty);

        final double totalDocumentos = documentos.fold(0, (double total, Documento documento) => total + documento.rcp);
        final double totalImpuestos = itemDocumento.fold(0, (double total, ItemDocumento item) => total + item.valorIva);
        final double totalPrefacturas = itemDocumento.fold(0, (double total, ItemDocumento prefactura) => total + prefactura.total);
        final Iterable<ItemDocumento> itemDocumentoWhitDocumentos = itemDocumento.where((ItemDocumento element) => element.documento > 0);
        final double valorFaltante = itemDocumentoWhitDocumentos.isNotEmpty ? (totalDocumentos - totalPrefacturas) : 0;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Theme.of(context).colorScheme.primary, offset: const Offset(-8, 0)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Cantidad Items:",
                      icon: Icons.file_copy_outlined,
                      content: Text("${itemDocumento.length}"),
                    ),
                    _BuildItemCard(
                      title: "Cantidad Documentos:",
                      icon: Icons.file_copy_outlined,
                      content: Text("${facturaBloc.state.documentos.length}"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Total Documentos:",
                      icon: Icons.paid_outlined,
                      content: CurrencyLabel(color: Colors.green, text: '${totalDocumentos.toInt()}'),
                    ),
                    _BuildItemCard(
                      title: "Valor Facturado:",
                      icon: Icons.price_check_outlined,
                      content: CurrencyLabel(color: Colors.blue, text: '${totalPrefacturas.toInt()}'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Faltante:",
                      icon: Icons.money_off_outlined,
                      content: CurrencyLabel(color: Colors.red, text: '${valorFaltante.toInt()}'),
                    ),
                    _BuildItemCard(
                      title: "Valor Impuesto:",
                      icon: Icons.currency_exchange_outlined,
                      content: CurrencyLabel(color: Colors.black87, text: '${totalImpuestos.toInt()}'),
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
    final TextStyle textStyle =
        TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400, fontSize: 14);

    return SizedBox(
      width: 300,
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 8),
          Text(title, style: textStyle),
          const SizedBox(width: 4),
          content,
        ],
      ),
    );
  }
}
