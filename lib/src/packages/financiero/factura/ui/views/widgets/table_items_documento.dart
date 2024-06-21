import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/resources/formatters/upper_case_formatter.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TableItemsDocumento extends StatelessWidget {
  const TableItemsDocumento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        final TableRow tableRowsTitle = TableRow(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
          children: const <Widget>[
            _CellTitle(title: "Item"),
            _CellTitle(title: "Documento"),
            _CellTitle(title: "Descripcion"),
            _CellTitle(title: "Valor"),
            _CellTitle(title: "Impuestos"),
            _CellTitle(title: "Total"),
            _CellTitle(title: "Accion"),
          ],
        );
        int index = 0;
        final List<TableRow> buildTableRows = state.itemDocumentos.map(
          (ItemDocumento itemDocumento) {
            index++;
            return TableRow(
              children: <Widget>[
                _CellContent(child: _BuildFieldItem(index)),
                _CellContent(child: _BuildFiledDocumento(item: itemDocumento)),
                _CellContent(child: _BuildFieldDescription(item: itemDocumento)),
                _CellContent(child: _BuildValor(item: itemDocumento)),
                _CellContent(child: _BuildImpuestos(item: itemDocumento)),
                _CellContent(child: _BuildTotal(total: itemDocumento.total)),
                _CellContent(child: _BuildFiledAccion(index: index)),
              ],
            );
          },
        ).toList();

        const Map<int, FractionColumnWidth> columnWidth = <int, FractionColumnWidth>{
          0: FractionColumnWidth(0.04),
          1: FractionColumnWidth(0.06),
          2: FractionColumnWidth(0.35),
          3: FractionColumnWidth(0.1),
          4: FractionColumnWidth(0.25),
          5: FractionColumnWidth(0.08),
          6: FractionColumnWidth(0.08),
        };
        return Table(
          border: TableBorder.all(color: Colors.grey.shade200),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: columnWidth,
          children: <TableRow>[tableRowsTitle, ...buildTableRows],
        );
      },
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
  final ItemDocumento item;

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
        item.documento.toString(),
        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
      ),
    );
  }
}

class _BuildFieldDescription extends StatelessWidget {
  final ItemDocumento item;
  const _BuildFieldDescription({required this.item});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String value) {
        item.descripcion = value;
      },
      inputFormatters: <TextInputFormatter>[UpperCaseFormatter()],
      initialValue: CustomFunctions.limpiarTexto(item.descripcion),
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

class _BuildValor extends StatelessWidget {
  final ItemDocumento item;
  const _BuildValor({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final int valor = item.valor.toInt();
    return CurrencyLabel(color: Colors.green.shade900, text: '${valor}');
  }
}

class _BuildImpuestos extends StatelessWidget {
  final ItemDocumento item;
  const _BuildImpuestos({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
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
        TableRow(
          children: <Widget>[
            const _CellContent(child: Text("Iva", style: TextStyle(fontWeight: FontWeight.bold))),
            const _CellContent(child: Text("19 %")),
            _CellContent(child: Text(r"$190000", style: TextStyle(color: Colors.green[900]))),
          ],
        ),
        const TableRow(
          children: <Widget>[
            _CellContent(child: Text("Reteiva", style: TextStyle(fontWeight: FontWeight.bold))),
            _CellContent(child: Text("1 %")),
            _CellContent(child: Text(r"$1900")),
          ],
        ),
        const TableRow(
          children: <Widget>[
            _CellContent(child: Text("Ica", style: TextStyle(fontWeight: FontWeight.bold))),
            _CellContent(child: Text("7 %")),
            _CellContent(child: Text(r"$2000")),
          ],
        ),
        const TableRow(
          children: <Widget>[
            _CellContent(child: Text("Reteica", style: TextStyle(fontWeight: FontWeight.bold))),
            _CellContent(child: Text("2 %")),
            _CellContent(child: Text(r"$300")),
          ],
        ),
      ],
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

class _BuildFiledAccion extends StatelessWidget {
  final int index;
  const _BuildFiledAccion({required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomSizeButton(
          onPressed: () {
            context.read<ItemDocumentoBloc>().add(RemoveItemByPositionFacturaEvent(index: index));
          },
          width: 32,
          icon: Icons.delete_outlined,
          color: Colors.red.shade800,
          iconColor: Colors.white,
        ),
        const SizedBox(width: 4),
        CustomSizeButton(width: 32, icon: Icons.refresh_outlined, onPressed: () {}),
      ],
    );
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
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
