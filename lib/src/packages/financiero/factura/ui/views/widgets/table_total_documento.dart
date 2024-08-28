import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/pdf_view.dart';
import 'package:switrans_2_0/src/util/resources/formatters/formatear_miles.dart';

class TableTotalDocumento extends StatelessWidget {
  const TableTotalDocumento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
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
                _CellTitle(title: key, color: Theme.of(context).colorScheme.onPrimaryContainer),
                const SizedBox(),
                _BuildValueCurrency(valor: value, color: key == "IVA" ? Colors.green : Colors.red),
                const SizedBox(),
              ],
            ),
          );
        });

        final TableRow tableRowsTitle = TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          children: <Widget>[
            _CellTitle(
              title: "Items",
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            _CellTitle(title: "$itemsLength", color: colorPrimaryContainer),
            _CellTitle(title: "Documentos", color: colorPrimaryContainer),
            _CellTitle(title: "$documentosLength", color: colorPrimaryContainer),
          ],
        );

        final TableRow tableRowsTotal = TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade300),
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
            _BuildValueCurrency(valor: subTotal, color: Colors.green),
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
            SizedBox(
              width: 500,
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade100),
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
            Container(
              width: 100,
              height: cantidadItem * 32.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
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
    return Center(
      child: Text(
        "COP \$${formatearMiles(valor.toString())}",
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size),
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
