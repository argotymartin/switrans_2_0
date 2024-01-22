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
      height: 600,
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
        minWidth: 60,
        width: 100,
        enableEditingMode: false,
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
                rendererContext.rowIdx.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Remesa',
        field: 'remesa',
        enableEditingMode: false,
        width: 200,
        minWidth: 120,
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return const SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "01051-22845 (734778)",
                ),
                Row(
                  children: [
                    Text(
                      "CC: ",
                      style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 10),
                    ),
                    Text(
                      "TENJO MCT SAS",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Tipo: ",
                      style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 10),
                    ),
                    Text(
                      "Provincia",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Obs',
        field: 'obs',
        minWidth: 200,
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
      ),
    ]);
    //rows.addAll(DummyData.rowsByColumns(length: 2, columns: columns));
    rows.addAll(RemesasDatasources.rowsByColumns(columns: columns));
  }

  Widget currencyRenderer(PlutoColumnRendererContext ctx) {
    assert(ctx.column.type.isCurrency);

    Color color = Colors.black;

    if (ctx.cell.value > 0) {
      color = Colors.green;
    } else if (ctx.cell.value < 0) {
      color = Colors.red;
    }

    return Text(
      ctx.column.type.applyFormat(ctx.cell.value),
      style: TextStyle(color: color),
      textAlign: TextAlign.end,
    );
  }
}
