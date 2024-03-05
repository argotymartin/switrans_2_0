import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CustomPlutoGridTable extends StatelessWidget {
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  final Function(dynamic value)? onRowChecked;
  final Function(dynamic value)? onRowDoubleTap;
  const CustomPlutoGridTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.onRowDoubleTap,
    this.onRowChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late PlutoGridStateManager stateManager;
    const double rowHeight = 48;
    const double titleHeight = 48;
    const double columnFilterHeight = 36;
    return Container(
      height: (rowHeight * (rows.length + 1)) + (titleHeight + columnFilterHeight),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
        },
        onRowChecked: onRowChecked,
        onRowDoubleTap: onRowDoubleTap,
        configuration: PlutoGridConfiguration(
          style: PlutoGridStyleConfig(
            checkedColor: Theme.of(context).colorScheme.primaryContainer,
            activatedColor: Theme.of(context).colorScheme.inversePrimary,
            activatedBorderColor: Theme.of(context).colorScheme.onInverseSurface,
            columnHeight: titleHeight,
            columnFilterHeight: columnFilterHeight,
            enableRowColorAnimation: true,
            rowHeight: rowHeight,
            gridBorderRadius: BorderRadius.circular(8),
            evenRowColor: Theme.of(context).colorScheme.surfaceVariant,
            gridBorderColor: Theme.of(context).colorScheme.primary,
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
}
