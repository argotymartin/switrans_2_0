import 'package:pluto_grid/pluto_grid.dart';

class TablePlutoGridDataSource {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  static PlutoRow rowByColumns(List<PlutoColumn> columns, Map<String, dynamic> dataColumn) {
    final Map<String, PlutoCell> cells = _cellsByColumn(columns, dataColumn);
    return PlutoRow(cells: cells);
  }

  static Map<String, PlutoCell> _cellsByColumn(List<PlutoColumn> columns, Map<String, dynamic> dataColumn) {
    return Map<String, PlutoCell>.fromEntries(
      columns.map(
        (PlutoColumn column) => MapEntry<String, PlutoCell>(
          column.field,
          PlutoCell(value: dataColumn[column.field]),
        ),
      ),
    );
  }
}
