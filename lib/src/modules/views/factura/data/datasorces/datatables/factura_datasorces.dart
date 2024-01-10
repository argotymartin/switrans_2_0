import 'package:flutter/material.dart';

class FacturaDatasources extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      color: const MaterialStatePropertyAll(Colors.white),
      index: index,
      cells: [
        DataCell(Text("$index")),
        const DataCell(SizedBox(width: 60, child: Text("01051-22845 (734778) TENJO MCT SAS"))),
        const DataCell(Text("\$ 280,000")),
        const DataCell(
          SizedBox(
            width: 130,
            child: Text(
              "SERVICIO SOLICITADO POR NELSON MENDEZ PARA EL DIA 26-DICIEMBRE-23, SENCILLO DE PLACA WFV 844, CONDUCTOR FABIO ROJAS, GPS Y COMUNICACIONES.DO: 2 VIAJES A TIENDAS, BOGOTASIN VERIFICAR PESO NI CONTENIDO Origen: TENJO Destino: BOGOTA, D.C.",
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        const DataCell(Text("Remision")),
        const DataCell(Text("\$ 420,000")),
        const DataCell(Text("\$ 0")),
        const DataCell(Text("\$ 420,000")),
        const DataCell(Text("\$ acciones")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
