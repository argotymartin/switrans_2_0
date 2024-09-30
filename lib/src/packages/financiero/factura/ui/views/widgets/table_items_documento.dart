import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/config.dart';
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
  late ScrollController _firstController;
  late ScrollController _secondController;

  @override
  void initState() {
    _firstController = ScrollController();
    _secondController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        const List<DataColumn> columns = <DataColumn>[
          DataColumn(label: _CellTitleSpacing(size: 0.1)),
          DataColumn(label: _CellTitleSpacing(size: 0.40)),
          DataColumn(label: _CellTitleSpacing(size: 0.1)),
          DataColumn(label: _CellTitleSpacing(size: 0.3)),
          DataColumn(label: _CellTitleSpacing(size: 0.1)),
        ];

        int index = 0;

        final List<DataRow> buildTableRows = state.documentosSelected.expand(
          (Documento documento) {
            return documento.itemDocumentos.map(
              (ItemDocumento item) {
                index++;
                return DataRow(
                  cells: <DataCell>[
                    DataCell(_CellContent(child: _BuildFiledDocumento(documento: documento, index: index))),
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
        final int heightTable = index <= 3 ? index : 3;
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primaryFixed),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            height: heightTable * 200 + 60,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: Container(
                    width: size.width - 80,
                    height: 60,
                    color: Theme.of(context).colorScheme.primaryFixedDim.withOpacity(0.4),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _CellTitle(size: 0.1, title: "Documento"),
                          _CellTitle(size: 0.40, title: "Descripcion"),
                          _CellTitle(size: 0.1, title: "SubTotal"),
                          _CellTitle(size: 0.3, title: "Impuestos"),
                          _CellTitle(size: 0.1, title: "Total a Pagar"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightTable * 200 - 2,
                  child: SingleChildScrollView(
                    controller: _secondController,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _firstController,
                      child: SingleChildScrollView(
                        controller: _firstController,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          clipBehavior: Clip.hardEdge,
                          headingRowColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primaryContainer),
                          dataRowMaxHeight: 200,
                          dataRowMinHeight: 170,
                          headingRowHeight: 0,
                          columnSpacing: 0,
                          horizontalMargin: 0,
                          border: TableBorder.all(
                            color: Theme.of(context).colorScheme.primaryFixedDim,
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                          ),
                          columns: columns,
                          rows: buildTableRows,
                        ),
                      ),
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

class _BuildFiledDocumento extends StatelessWidget {
  final Documento documento;
  final int index;

  const _BuildFiledDocumento({required this.documento, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                ),
                child: Text(
                  documento.documento.toString(),
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  documento.valorEgreso > documento.valorIngreso
                      ? AnimateIcon(
                          onTap: () {},
                          iconType: IconType.continueAnimation,
                          height: 70,
                          width: 70,
                          color: Colors.orangeAccent,
                          animateIcon: AnimateIcons.expensive,
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ],
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
            border: TableBorder.all(color: Theme.of(context).colorScheme.primaryFixedDim, borderRadius: BorderRadius.circular(8)),
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
    return Padding(padding: const EdgeInsets.all(16), child: CurrencyLabel(color: Colors.green.shade900, text: '${total.toInt()}'));
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
        final double width = state.isOpenMenu! ? sizeC - kWidthSidebar - 80 : sizeC - 80;

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

class _CellTitleSpacing extends StatelessWidget {
  final double size;
  const _CellTitleSpacing({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        final Size sizeM = MediaQuery.of(context).size;
        final double sizeC = sizeM.width < 1600 ? 1600 : sizeM.width;
        final double width = state.isOpenMenu! ? sizeC - kWidthSidebar - 80 : sizeC - 80;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: width * size,
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
