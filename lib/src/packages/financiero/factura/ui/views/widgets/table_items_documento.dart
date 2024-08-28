import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/resources/formatters/formatear_miles.dart';
import 'package:switrans_2_0/src/util/resources/formatters/upper_case_formatter.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TableItemsDocumento extends StatelessWidget {
  const TableItemsDocumento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        final List<Widget> acciones = <Widget>[];
        final TableRow tableRowsTitle = TableRow(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
          children: const <Widget>[
            _CellTitle(title: "Item"),
            _CellTitle(title: "Documento"),
            _CellTitle(title: "Descripcion"),
            _CellTitle(title: "SubTotal"),
            _CellTitle(title: "Impuestos"),
            _CellTitle(title: "Total Valor a Pagar"),
          ],
        );
        int index = 0;
        final List<TableRow> buildTableRows = state.documentosSelected.expand(
          (Documento documento) {
            acciones.add(_BuildButtonClear(documento: documento));
            return documento.itemDocumentos.map(
              (ItemDocumento item) {
                index++;
                return TableRow(
                  children: <Widget>[
                    _CellContent(child: _BuildFieldItem(index)),
                    _CellContent(child: _BuildFiledDocumento(item: documento.documento)),
                    _CellContent(child: _BuildFieldDescription(itemDocumento: item, descripcion: documento.descripcion)),
                    _CellContent(child: _BuildSubtotal(value: item.subtotal)),
                    _CellContent(child: _BuildImpuestos(impuestos: item.impuestos)),
                    _CellContent(child: _BuildTotal(total: item.total)),
                  ],
                );
              },
            ).toList();
          },
        ).toList();

        const Map<int, FractionColumnWidth> columnWidth = <int, FractionColumnWidth>{
          0: FractionColumnWidth(0.04),
          1: FractionColumnWidth(0.06),
          2: FractionColumnWidth(0.35),
          3: FractionColumnWidth(0.1),
          4: FractionColumnWidth(0.25),
          5: FractionColumnWidth(0.1),
        };
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade200),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: columnWidth,
                children: <TableRow>[tableRowsTitle, ...buildTableRows],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                  width: 80,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    "Borrar",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
                ...acciones,
              ],
            ),
          ],
        );
      },
    );
  }
}

class _BuildButtonClear extends StatelessWidget {
  final Documento documento;
  const _BuildButtonClear({required this.documento});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      width: 80,
      height: 148 * documento.itemDocumentos.length.toDouble(),
      child: CustomSizeButton(
        onPressed: () {
          context.read<FormFacturaBloc>().add(RemoveDocumentoFormFacturaEvent(documento));
        },
        size: 32,
        icon: Icons.delete_outlined,
        color: Colors.red,
        iconColor: Colors.white,
      ),
    );
  }
}

class _BuildFieldItem extends StatelessWidget {
  final int index;
  const _BuildFieldItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            index.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _BuildFiledDocumento extends StatelessWidget {
  final int item;

  const _BuildFiledDocumento({required this.item});

  @override
  Widget build(BuildContext context) {
    return Chip(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(),
      side: BorderSide.none,
      elevation: 4,
      label: Text(
        item.toString(),
        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
      ),
    );
  }
}

class _BuildFieldDescription extends StatelessWidget {
  final String descripcion;
  final ItemDocumento itemDocumento;
  const _BuildFieldDescription({required this.itemDocumento, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    String value = itemDocumento.servicioNombre;
    if (itemDocumento.servicioCodigo == 1) {
      value += " - $descripcion";
    }
    return TextFormField(
      onChanged: (String value) {
        //item.descripcion = value;
      },
      inputFormatters: <TextInputFormatter>[UpperCaseFormatter()],
      initialValue: CustomFunctions.limpiarTexto(value),
      autovalidateMode: AutovalidateMode.always,
      maxLines: 7,
      minLines: 5,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 10),
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _BuildSubtotal extends StatelessWidget {
  final double value;
  const _BuildSubtotal({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final int valor = value.toInt();
    return CurrencyLabel(color: Colors.green.shade900, text: '${valor}');
  }
}

class _BuildImpuestos extends StatelessWidget {
  final ItemImpuesto impuestos;
  const _BuildImpuestos({
    required this.impuestos,
  });

  @override
  Widget build(BuildContext context) {
    final List<TableRow> children = <TableRow>[];

    final TableRow childTotal = TableRow(
      children: <Widget>[
        const SizedBox(),
        const _CellContent(child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
        _CellContent(
          child: Text(
            "\$${formatearMiles(impuestos.total.toString())}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    for (final Impuesto impuesto in impuestos.impuestos) {
      children.add(
        TableRow(
          children: <Widget>[
            _CellContent(child: Text(impuesto.nombre, style: const TextStyle(fontWeight: FontWeight.bold))),
            _CellContent(
              child: Text(
                "${impuesto.porcentaje?.toStringAsFixed(2)} x ${impuesto.factorConversion}",
                style: const TextStyle(fontSize: 12),
              ),
            ),
            _CellContent(
              child: Text("\$${formatearMiles(impuesto.valor.toString())}", style: TextStyle(color: Colors.green[900], fontSize: 14)),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 140,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade200),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
            children: const <Widget>[
              _CellTitleImpuesto(title: "Nombre"),
              _CellTitleImpuesto(title: "Porcentaje"),
              _CellTitleImpuesto(title: "Valor"),
            ],
          ),
          ...children,
          childTotal,
        ],
      ),
    );
  }
}

class _BuildTotal extends StatelessWidget {
  final double total;
  const _BuildTotal({required this.total});

  @override
  Widget build(BuildContext context) {
    return CurrencyLabel(color: Colors.green.shade900, text: '${total.toInt()}');
  }
}

class _CellTitle extends StatelessWidget {
  final String title;
  const _CellTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 16),
        ),
      ),
    );
  }
}

class _CellTitleImpuesto extends StatelessWidget {
  final String title;
  const _CellTitleImpuesto({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
    );
  }
}

class _CellContent extends StatelessWidget {
  final Widget child;
  const _CellContent({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: child,
      ),
    );
  }
}
