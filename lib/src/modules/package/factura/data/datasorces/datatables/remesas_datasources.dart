import 'package:pluto_grid/pluto_grid.dart';

class RemesasDatasources {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  static PlutoRow rowByColumns(List<PlutoColumn> columns, Remesa remesa) {
    return PlutoRow(cells: _cellsByColumn(columns, remesa));
  }

  static Map<String, PlutoCell> _cellsByColumn(List<PlutoColumn> columns, Remesa remesa) {
    final cells = <String, PlutoCell>{};
    for (var column in columns) {
      cells[column.field] = PlutoCell(
        value: valueByColumnType(column, remesa),
      );
    }
    return cells;
  }

  static List<PlutoRow> rowsByColumns({
    required List<PlutoColumn> columns,
  }) {
    return remesas.map((remesa) => rowByColumns(columns, remesa)).toList();
  }

  static dynamic valueByColumnType(PlutoColumn column, Remesa remesa) {
    if (column.field == "item") {
      return column.frozen.index;
    } else if (column.field == "remesa") {
      return remesa.remesa;
    } else if (column.field == "obs") {
      return remesa.obervaciones;
    } else if (column.field == "adiciones") {
      return remesa.adiciones;
    } else if (column.field == "descuentos") {
      return remesa.descuentos;
    } else if (column.field == "flete") {
      return remesa.flete;
    } else if (column.field == "tarifaBase") {
      return remesa.tarifaBase;
    } else if (column.field == "rcp") {
      return remesa.rcp;
    }
  }

  static List<Remesa> remesas = [
    Remesa(
      remesa: "01051-22845 (734778)",
      obervaciones:
          "SERVICIO SOLICITADO POR NELSON MENDEZ PARA EL DIA 26-DICIEMBRE-23, SENCILLO DE PLACA WFV 844, CONDUCTOR FABIO ROJAS, GPS Y COMUNICACIONES.DO: 2 VIAJES A TIENDAS, BOGOTASIN VERIFICAR PESO NI CONTENIDO Origen: TENJO Destino: BOGOTA, D.C.",
      adiciones: "2000",
      descuentos: "300",
      flete: "400",
      tarifaBase: "2500",
      rcp: "4800",
    ),
    Remesa(
      remesa: "01045-54214 (458541)",
      obervaciones:
          "SERVICIO SOLICITADO POR CARLOS PEREZ PARA EL DIA 15-ENERO-24, SENCILLO DE PLACA ABC 123, CONDUCTOR JUAN GOMEZ, GPS Y COMUNICACIONES.DO: 3 VIAJES A TIENDAS, MEDELLÍNSIN VERIFICAR PESO NI CONTENIDO Origen: RIONEGRO Destino: MEDELLÍN, ANTIOQUIA",
      adiciones: "25000",
      descuentos: "3000",
      flete: "280000",
      tarifaBase: "420000",
      rcp: "42000",
    ),
    Remesa(
      remesa: "01045-22845 (459321)",
      obervaciones:
          "SERVICIO SOLICITADO POR MARÍA RAMIREZ PARA EL DIA 10-FEBRERO-24, SENCILLO DE PLACA XYZ 789, CONDUCTOR LUIS MARTÍNEZ, GPS Y COMUNICACIONES.DO: 4 VIAJES A TIENDAS, CALISIN VERIFICAR PESO NI CONTENIDO Origen: PALMIRA Destino: CALI, VALLE DEL CAUCA",
      adiciones: "10000",
      descuentos: "2100",
      flete: "452000",
      tarifaBase: "4568",
      rcp: "45856",
    )
  ];
}

class Remesa {
  final String remesa;
  final String obervaciones;
  final String adiciones;
  final String descuentos;
  final String flete;
  final String tarifaBase;
  final String rcp;
  Remesa({
    required this.remesa,
    required this.obervaciones,
    required this.adiciones,
    required this.descuentos,
    required this.flete,
    required this.tarifaBase,
    required this.rcp,
  });
}
