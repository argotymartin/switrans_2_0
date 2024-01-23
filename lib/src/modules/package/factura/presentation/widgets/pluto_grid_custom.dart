import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/datasorces/datatables/remesas_datasources.dart';

class PlutoGridCustom extends StatefulWidget {
  const PlutoGridCustom({Key? key}) : super(key: key);

  @override
  State<PlutoGridCustom> createState() => _PlutoGridCustomState();
}

class _PlutoGridCustomState extends State<PlutoGridCustom> {
  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];
  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (120 * 3) + (48 + 60 + 36),
      padding: const EdgeInsets.all(15),
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
        },
        onChanged: (PlutoGridOnChangedEvent event) {},
        onRowChecked: (event) {},
        configuration: PlutoGridConfiguration(
          style: PlutoGridStyleConfig(
            checkedColor: Theme.of(context).colorScheme.primaryContainer,
            activatedColor: Theme.of(context).colorScheme.onPrimary,
            activatedBorderColor: Theme.of(context).colorScheme.primary,
            columnHeight: 48,
            columnFilterHeight: 60,
            rowHeight: 120,
          ),
          columnSize: const PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.scale),
          scrollbar: const PlutoGridScrollbarConfig(
            longPressDuration: Duration.zero,
            onlyDraggingThumb: false,
          ),
          localeText: const PlutoGridLocaleText.spanish(),
        ),
      ),
    );
  }

  void getData() {
    columns.addAll([
      PlutoColumn(
        title: 'Item',
        field: 'item',
        suppressedAutoSize: true,
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableRowChecked: true,
        minWidth: 120,
        width: 124,
        renderer: (rendererContext) {
          return Container(
            width: 12,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                rendererContext.cell.value.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Remesa',
        field: 'remesa',
        width: 160,
        minWidth: 160,
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          final cellValue = rendererContext.cell.value.toString();
          final valRemesa = cellValue.split("CC:")[0];
          final valAdicional = cellValue.split("CC:")[1].trim(); // Trim para eliminar espacios adicionales

          final ccParts = valAdicional.split("Tipo:");
          final cc = ccParts[0].trim(); // Trim para eliminar espacios adicionales
          final tipo = ccParts[1].trim();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valRemesa,
              ),
              Row(
                children: [
                  const Icon(Icons.monetization_on_outlined, size: 16),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12),
                      children: [
                        const TextSpan(
                          text: 'CC: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: cc)
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.fire_truck_outlined, size: 16),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12),
                      children: [
                        const TextSpan(
                          text: 'Tipo: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: tipo)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'Obs',
        field: 'obs',
        minWidth: 220,
        width: 250,
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return Text(
            rendererContext.row.cells[rendererContext.column.field]!.value.toString(),
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10),
          );
        },
      ),
      PlutoColumn(
        title: 'Adiciones',
        field: 'adiciones',
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        enableEditingMode: true,
        renderer: (rendererContext) {
          return Text(
            rendererContext.column.type.applyFormat(rendererContext.cell.value),
            style: TextStyle(color: Colors.green.shade700),
            textAlign: TextAlign.end,
          );
        },
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            filter: (cell) => cell.row.checked == true,
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.sum,
            format: '#,###',
            alignment: Alignment.center,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(
                  text: 'Sum',
                  style: TextStyle(color: Colors.red),
                ),
                const TextSpan(text: ' : '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
      PlutoColumn(
        title: 'Descuentos',
        field: 'descuentos',
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        renderer: (rendererContext) {
          return Text(
            rendererContext.column.type.applyFormat(rendererContext.cell.value),
            style: TextStyle(color: Colors.red.shade700),
          );
        },
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            filter: (cell) => cell.row.checked == true,
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.sum,
            format: '#,###',
            alignment: Alignment.center,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(
                  text: 'Sum',
                  style: TextStyle(color: Colors.red),
                ),
                const TextSpan(text: ' : '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
      PlutoColumn(
        title: 'Flete',
        field: 'flete',
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        renderer: (rendererContext) {
          return Text(
            rendererContext.column.type.applyFormat(rendererContext.cell.value),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.red.shade700),
          );
        },
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            filter: (cell) => cell.row.checked == true,
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.sum,
            format: '#,###',
            alignment: Alignment.center,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(
                  text: 'Sum',
                  style: TextStyle(color: Colors.red),
                ),
                const TextSpan(text: ' : '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
      PlutoColumn(
        title: 'Tarifa Base',
        field: 'tarifaBase',
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        renderer: (rendererContext) {
          return Text(
            rendererContext.column.type.applyFormat(rendererContext.cell.value),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.green.shade700),
          );
        },
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            filter: (cell) => cell.row.checked == true,
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.sum,
            format: '#,###',
            alignment: Alignment.center,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(
                  text: 'Sum',
                  style: TextStyle(color: Colors.red),
                ),
                const TextSpan(text: ' : '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
      PlutoColumn(
        title: 'R.C.P',
        field: 'rcp',
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        renderer: (rendererContext) {
          return Text(
            rendererContext.column.type.applyFormat(rendererContext.cell.value),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold),
          );
        },
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            filter: (cell) => cell.row.checked == true,
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.sum,
            format: '#,###',
            alignment: Alignment.center,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(
                  text: 'Sum',
                  style: TextStyle(color: Colors.red),
                ),
                const TextSpan(text: ' : '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
    ]);
    rows.addAll(RemesasDatasources.rowsByColumns(columns: columns));
  }
}
