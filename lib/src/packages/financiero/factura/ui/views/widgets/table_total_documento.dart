import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/pdf_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TableTotalDocumento extends StatelessWidget {
  const TableTotalDocumento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        double total = 0;
        double subTotal = 0;
        int cantidadItem = 3;
        final int documentosLength = state.documentosSelected.length;
        final int itemsLength = state.documentosSelected.fold(0, (int total, Documento e) => total + e.itemDocumentos.length);
        final Color colorPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
        final List<TableRow> childrenImpuestos = <TableRow>[];
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
        mapImpuestos.forEach((String key, double value) {
          cantidadItem++;
          childrenImpuestos.add(
            TableRow(
              children: <Widget>[
                _CellTitle(title: key, color: AppTheme.colorTextTheme),
                const SizedBox(),
                _BuildValueCurrency(valor: value, color: key == "IVA" ? Colors.green : Colors.red),
                const SizedBox(),
              ],
            ),
          );
        });

        final TableRow tableRowsTitle = TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16)),
          ),
          children: <Widget>[
            _CellTitle(
              title: "Items",
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            _BuildValueNumber(valor: itemsLength, color: colorPrimaryContainer),
            _CellTitle(title: "Documentos", color: colorPrimaryContainer),
            _BuildValueNumber(valor: documentosLength, color: colorPrimaryContainer),
          ],
        );

        final TableRow tableRowsTotal = TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16)),
          ),
          children: <Widget>[
            _CellTitle(title: "Total", color: colorPrimaryContainer),
            const SizedBox(),
            _BuildValueCurrency(valor: total, color: Colors.green, size: 18),
            const SizedBox(),
          ],
        );
        final TableRow tableRowsSubTotal = TableRow(
          children: <Widget>[
            _CellTitle(title: "SubTotal", color: colorPrimaryContainer),
            const SizedBox(),
            _BuildValueCurrency(valor: subTotal, color: AppTheme.colorTextTheme),
            const SizedBox(),
          ],
        );
        const Map<int, FractionColumnWidth> columnWidth = <int, FractionColumnWidth>{
          0: FractionColumnWidth(0.4),
          1: FractionColumnWidth(0.1),
          2: FractionColumnWidth(0.4),
          3: FractionColumnWidth(0.1),
        };
        final Size size = MediaQuery.of(context).size;
        return Row(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                child: Table(
                  border: TableBorder.all(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      bottomLeft: const Radius.circular(16),
                    ),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: columnWidth,
                  children: <TableRow>[
                    tableRowsTitle,
                    tableRowsSubTotal,
                    ...childrenImpuestos,
                    tableRowsTotal,
                  ],
                ),
              ),
            ),
            Container(
              height: cantidadItem * 35.7,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: cantidadItem * 8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primaryFixedDim),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
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
        );
      },
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
    return Padding(
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
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}

class _BuildValueNumber extends StatelessWidget {
  final int valor;
  final Color color;
  const _BuildValueNumber({
    required this.valor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$valor",
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
