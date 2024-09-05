import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/constans/constants.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/resources/formatters/upper_case_formatter.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class TableItemsDocumento extends StatefulWidget {
  const TableItemsDocumento({
    super.key,
  });

  @override
  State<TableItemsDocumento> createState() => _TableItemsDocumentoState();
}

class _TableItemsDocumentoState extends State<TableItemsDocumento> {
  final ScrollController _firstController = ScrollController();

  @override
  void dispose() {
    _firstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        final List<Widget> acciones = <Widget>[];

        const List<DataColumn> columns = <DataColumn>[
          DataColumn(label: _CellTitle(size: 0.05, title: "Item")),
          DataColumn(label: _CellTitle(size: 0.1, title: "Documento")),
          DataColumn(label: _CellTitle(size: 0.35, title: "Descripcion")),
          DataColumn(label: _CellTitle(size: 0.1, title: "SubTotal")),
          DataColumn(label: _CellTitle(size: 0.3, title: "Impuestos")),
          DataColumn(label: _CellTitle(size: 0.1, title: "Total Valor a Pagar")),
        ];

        int index = 0;
        final List<DataRow> buildTableRows = state.documentosSelected.expand(
          (Documento documento) {
            acciones.add(_BuildButtonClear(documento: documento));
            return documento.itemDocumentos.map(
              (ItemDocumento item) {
                index++;
                return DataRow(
                  cells: <DataCell>[
                    DataCell(_CellContent(child: _BuildFieldItem(index))),
                    DataCell(_CellContent(child: _BuildFiledDocumento(item: documento.documento))),
                    DataCell(
                      _CellContent(child: _BuildFieldDescription(itemDocumento: item, descripcion: documento.descripcion)),
                    ),
                    DataCell(_CellContent(child: _BuildSubtotal(value: item.subtotal))),
                    DataCell(_CellContent(child: _BuildImpuestos(impuestos: item.impuestos))),
                    DataCell(_CellContent(child: _BuildTotal(total: item.total))),
                  ],
                );
              },
            ).toList();
          },
        ).toList();

        return SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _firstController,
                  child: SingleChildScrollView(
                    controller: _firstController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primaryContainer),
                      dataRowMaxHeight: 170,
                      dataRowMinHeight: 170,
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      border: TableBorder.all(color: Theme.of(context).colorScheme.primaryFixedDim),
                      columns: columns,
                      rows: buildTableRows,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(color: Theme.of(context).colorScheme.primaryFixedDim),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    width: 80,
                    child: Text(
                      "Borrar",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 16),
                    ),
                  ),
                  ...acciones,
                ],
              ),
            ],
          ),
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
        border: Border.all(color: Theme.of(context).colorScheme.primaryFixedDim),
      ),
      width: 80,
      height: 171 * documento.itemDocumentos.length.toDouble(),
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
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
    );
  }
}

class _BuildFiledDocumento extends StatelessWidget {
  final int item;

  const _BuildFiledDocumento({required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chip(
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
    final Size size = MediaQuery.of(context).size;
    String value = itemDocumento.servicioNombre;
    if (itemDocumento.servicioCodigo == 1) {
      value += " - $descripcion";
    }
    return Container(
      constraints: BoxConstraints(maxWidth: size.width * 0.4, minWidth: size.width * 0.2),
      child: TextFormField(
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
    return CurrencyLabel(color: AppTheme.colorTextTheme, text: '${valor}');
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
          child: CurrencyLabel(
            text: '${impuestos.total.toInt()}',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    for (final Impuesto impuesto in impuestos.impuestos) {
      children.add(
        TableRow(
          children: <Widget>[
            _CellContent(child: Text(impuesto.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            _CellContent(
              child: Text(
                "${impuesto.porcentaje?.toStringAsFixed(2)} x ${impuesto.factorConversion}",
                style: const TextStyle(fontSize: 12),
              ),
            ),
            _CellContent(
              child: CurrencyLabel(
                text: '${impuesto.valor.toInt()}',
                color: impuesto.nombre == "IVA" ? Colors.green.shade800 : Colors.red.shade800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300,
          child: Table(
            border: TableBorder.all(color: Theme.of(context).colorScheme.primaryFixedDim),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiaryContainer),
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
        ),
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
  final double size;
  const _CellTitle({
    required this.title,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        final Size sizeM = MediaQuery.of(context).size;
        final double sizeC = sizeM.width < 1600 ? 1600 : sizeM.width;
        final double width = state.isOpenMenu! ? sizeC - kWidthSidebar - 158 : sizeC - 158;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: width * size,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 16),
          ),
        );
      },
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
          style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.colorTextTheme),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: child,
    );
  }
}
