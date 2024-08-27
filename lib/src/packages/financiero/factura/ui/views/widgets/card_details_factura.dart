import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/pdf_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class CardDetailsFactura extends StatelessWidget {
  const CardDetailsFactura({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc facturaBloc = context.read<FormFacturaBloc>();

    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        final List<Documento> documentos = facturaBloc.state.documentos;
        final Iterable<Documento> itemDocumento = state.documentosSelected.where((Documento element) => element.impuestos.isNotEmpty);

        final double totalDocumentos = documentos.fold(0, (double total, Documento documento) => total + documento.valorTotal);
        final double totalPrefacturas = itemDocumento.fold(0, (double total, Documento prefactura) => total + prefactura.valorEgreso);

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
            child: Wrap(
              children: <Widget>[
                Column(
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
                Column(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Total Neto:",
                      icon: Icons.paid_outlined,
                      content: CurrencyLabel(color: Colors.green, text: '${totalDocumentos.toInt()}'),
                    ),
                    _BuildItemCard(
                      title: "Valor Iva:",
                      icon: Icons.price_check_outlined,
                      content: CurrencyLabel(color: Colors.blue, text: '${totalPrefacturas.toInt()}'),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Total Reteiva:",
                      icon: Icons.paid_outlined,
                      content: CurrencyLabel(color: Colors.green, text: '${totalDocumentos.toInt()}'),
                    ),
                    _BuildItemCard(
                      title: "Valor Total Reteica:",
                      icon: Icons.price_check_outlined,
                      content: CurrencyLabel(color: Colors.blue, text: '${totalPrefacturas.toInt()}'),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _BuildItemCard(
                      title: "Valor Total Retefuente:",
                      icon: Icons.paid_outlined,
                      content: CurrencyLabel(color: Colors.green, text: '${totalDocumentos.toInt()}'),
                    ),
                    _BuildItemCard(
                      title: "Valor Total:",
                      icon: Icons.price_check_outlined,
                      content: CurrencyLabel(color: Colors.blue, text: '${totalPrefacturas.toInt()}'),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        content: SizedBox(width: size.width * 0.7, child: const PdfView()),
                        actions: <Widget>[
                          FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
                        ],
                      ),
                    );
                  },
                  icon: Image.asset(
                    "assets/file-pdf-color-red-icon.png",
                    width: 48,
                  ),
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
