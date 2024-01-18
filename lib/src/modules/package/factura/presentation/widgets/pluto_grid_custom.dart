import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/datasorces/datatables/data_dumy.dart';

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
      height: 310,
      padding: const EdgeInsets.all(15),
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
        },
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        onRowChecked: (event) {
          print(event);
        },
        configuration: PlutoGridConfiguration(
          style: PlutoGridStyleConfig(
            checkedColor: Theme.of(context).colorScheme.primaryContainer,
            activatedColor: Theme.of(context).colorScheme.onPrimary,
            activatedBorderColor: Theme.of(context).colorScheme.primary,
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
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableRowChecked: true,
        minWidth: 60,
        width: 100,
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
                "${rendererContext.rowIdx}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Remesa',
        field: 'remesa',
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return const SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("01051-22845 (734778)"),
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
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return const SizedBox(
            child: Text(
              "SERVICIO SOLICITADO POR NELSON MENDEZ PARA EL DIA 26-DICIEMBRE-23, SENCILLO DE PLACA WFV 844, CONDUCTOR FABIO ROJAS, GPS Y COMUNICACIONES.DO: 2 VIAJES A TIENDAS, BOGOTASIN VERIFICAR PESO NI CONTENIDO Origen: TENJO Destino: BOGOTA, D.C.",
              style: TextStyle(fontSize: 10),
            ),
          );
        },
      ),
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'column5',
        field: 'column5',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        renderer: (rendererContext) {
          return Container(
            height: 200,
            width: 400,
            color: Colors.red,
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 20,
                  color: Colors.white,
                  child: Column(
                    children: [Text("hola")],
                  ),
                ),
                Container(
                  width: 180,
                  height: 10,
                  color: Colors.yellow,
                  child: Column(),
                )
              ],
            ),
          );
        },
      ),
    ]);
    rows.addAll(DummyData.rowsByColumns(length: 2, columns: columns));
  }
}
