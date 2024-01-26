import 'package:pluto_grid/pluto_grid.dart';

class TablePlutoGridDataSource {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  static PlutoRow rowByColumns(List<PlutoColumn> columns, bool isChecked, Map<String, dynamic> dataColumn) {
    final cells = _cellsByColumn(columns, dataColumn);
    return PlutoRow(checked: isChecked, cells: cells);
  }

  static Map<String, PlutoCell> _cellsByColumn(List<PlutoColumn> columns, Map<String, dynamic> dataColumn) {
    return Map.fromEntries(columns.map((column) => MapEntry(column.field, PlutoCell(value: dataColumn[column.field]))));
  }
}
