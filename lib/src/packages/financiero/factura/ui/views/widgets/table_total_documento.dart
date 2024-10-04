import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/pdf_view.dart';
import 'package:switrans_2_0/src/util/resources/formatters/to_title_case_text.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TableTotalDocumento extends StatelessWidget {
  const TableTotalDocumento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        final FacturaBloc facturaBloc = context.read<FacturaBloc>();
        final FormFacturaRequest request = facturaBloc.request;
        final Empresa empresaSelect = state.empresas.firstWhere((Empresa element) => element.codigo == state.empresa);
        final EntryAutocomplete cliente =
            state.entriesClientes.firstWhere((EntryAutocomplete element) => element.codigo == request.cliente);
        double total = 0;
        double subTotal = 0;
        final int documentosLength = state.documentosSelected.length;
        final int itemsLength = state.documentosSelected.fold(0, (int total, Documento e) => total + e.itemDocumentos.length);
        final Color colorPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
        final List<_BuildContent> childrenImpuestos = <_BuildContent>[];
        final Map<String, double> mapImpuestos = <String, double>{};

        for (final Documento doc in state.documentosSelected) {
          for (final ItemDocumento item in doc.itemDocumentos) {
            subTotal += item.subtotal;
            total += item.total;
          }
          for (final Impuesto imp in doc.impuestos) {
            mapImpuestos.update(
              imp.nombre,
              (double existingValue) => existingValue + imp.valor,
              ifAbsent: () => imp.valor,
            );
          }
        }

        final _BuildContent rowEmpresa = _BuildContent(
          text: "Empresa",
          icon: Icons.factory_outlined,
          content: _BuildValueText(text: empresaSelect.nombre, color: colorPrimaryContainer),
          size: 330,
        );

        final _BuildContent rowCliente = _BuildContent(
          text: "Cliente",
          icon: Icons.assignment_ind_outlined,
          content: _BuildValueText(text: cliente.title, color: colorPrimaryContainer),
          size: 330,
        );

        final _BuildContent rowItems = _BuildContent(
          text: "Items",
          icon: Icons.numbers,
          content: _BuildValueText(text: itemsLength.toString(), color: colorPrimaryContainer),
          size: 330,
        );

        final _BuildContent rowDocumentos = _BuildContent(
          text: "Documentos",
          icon: Icons.numbers,
          content: _BuildValueText(text: documentosLength.toString(), color: colorPrimaryContainer),
          size: 330,
        );

        mapImpuestos.forEach((String key, double value) {
          childrenImpuestos.add(
            _BuildContent(
              text: toTitleCase(key),
              icon: Icons.paid_outlined,
              content: _BuildValueCurrency(valor: value, color: key == "IVA" ? Colors.green : Colors.red),
              size: 260,
            ),
          );
        });

        final _BuildContent tableRowsSubTotal = _BuildContent(
          text: "SubTotal",
          icon: Icons.paid_outlined,
          content: _BuildValueCurrency(valor: subTotal, color: AppTheme.colorTextTheme),
          size: 260,
        );

        final _BuildContent tableRowsTotal = _BuildContent(
          text: "Total",
          icon: Icons.paid_outlined,
          content: _BuildValueCurrency(valor: total, color: Colors.green, size: 18),
          size: 260,
          background: Theme.of(context).colorScheme.surfaceContainerLow,
        );

        final Size size = MediaQuery.of(context).size;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: Theme.of(context).colorScheme.inversePrimary,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(0, 5),
                blurRadius: 16,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              spacing: 12,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    rowEmpresa,
                    rowCliente,
                    rowDocumentos,
                    rowItems,
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    tableRowsSubTotal,
                    ...childrenImpuestos,
                    tableRowsTotal,
                  ],
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 40),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.primaryFixedDim),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          content: SizedBox(
                            width: size.width * 0.8,
                            child: PdfView(documentos: state.documentos),
                          ),
                          actions: <Widget>[
                            FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
                          ],
                        ),
                      );
                    },
                    icon: Image.asset(
                      "assets/file-pdf-color-red-icon.png",
                      width: 60,
                    ),
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

class _BuildContent extends StatelessWidget {
  final String text;
  final Widget content;
  final IconData icon;
  final double size;
  final Color background;
  const _BuildContent({
    required this.text,
    required this.content,
    required this.icon,
    required this.size,
    this.background = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.surfaceDim),
        borderRadius: BorderRadius.circular(8),
        color: background,
      ),
      child: Wrap(
        children: <Widget>[
          Icon(icon),
          _CellTitle(title: text, color: Theme.of(context).colorScheme.onPrimaryContainer),
          content,
        ],
      ),
    );
  }
}

class _BuildValueCurrency extends StatelessWidget {
  final double valor;
  final Color color;
  final double size;
  const _BuildValueCurrency({
    required this.valor,
    required this.color,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.only(right: 8),
      child: CurrencyLabel(
        text: '${valor.toInt()}',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CellTitle extends StatelessWidget {
  final String title;
  final Color color;
  const _CellTitle({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400, color: color),
      ),
    );
  }
}

class _BuildValueText extends StatelessWidget {
  final String text;
  final Color color;
  const _BuildValueText({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
