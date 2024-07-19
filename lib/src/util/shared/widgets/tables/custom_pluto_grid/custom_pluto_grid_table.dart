import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

class CustomPlutoGridTable extends StatelessWidget {
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  final Function(PlutoGridOnRowCheckedEvent value)? onRowChecked;
  final Function(PlutoGridOnRowCheckedEvent value)? onRowDoubleTap;
  final bool columnFilter;
  const CustomPlutoGridTable({
    required this.columns,
    required this.rows,
    this.onRowDoubleTap,
    this.onRowChecked,
    this.columnFilter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late PlutoGridStateManager stateManager;
    const double rowHeight = 48;
    const double titleHeight = 48;
    final double columnFilterHeight = columnFilter ? 36 : 0;
    return Container(
      height: (rowHeight * (rows.length + 1)) + (titleHeight + columnFilterHeight),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          if (columnFilter) {
            stateManager.setShowColumnFilter(true);
          }
        },
        onRowChecked: onRowChecked,
        mode: PlutoGridMode.select,
        configuration: PlutoGridConfiguration.dark(
          enableMoveHorizontalInEditing: true,
          enableMoveDownAfterSelecting: true,
          style: Brightness.dark == Theme.of(context).brightness
              ? PlutoGridStyleConfig.dark(
                  rowColor: AppTheme.colorThemeSecundary,
                  oddRowColor: Theme.of(context).colorScheme.surfaceContainerLow,
                  checkedColor: Theme.of(context).colorScheme.inversePrimary,
                  activatedColor: Theme.of(context).colorScheme.onPrimary,
                  gridBackgroundColor: AppTheme.colorThemePrimary,
                  activatedBorderColor: Theme.of(context).colorScheme.primary,
                  columnHeight: titleHeight,
                  iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  menuBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  columnFilterHeight: columnFilterHeight,
                  enableRowColorAnimation: true,
                  rowHeight: rowHeight,
                  gridBorderRadius: BorderRadius.circular(8),
                  evenRowColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  gridBorderColor: Theme.of(context).colorScheme.primary,
                )
              : PlutoGridStyleConfig(
                  rowColor: AppTheme.colorThemePrimary,
                  oddRowColor: AppTheme.colorThemePrimary.withOpacity(0.8),
                  checkedColor: Theme.of(context).colorScheme.inversePrimary,
                  activatedColor: Theme.of(context).colorScheme.onPrimary,
                  gridBackgroundColor: AppTheme.colorThemePrimary,
                  activatedBorderColor: Theme.of(context).colorScheme.primary,
                  columnHeight: titleHeight,
                  iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  menuBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  columnFilterHeight: columnFilterHeight,
                  enableRowColorAnimation: true,
                  rowHeight: rowHeight,
                  gridBorderRadius: BorderRadius.circular(8),
                  evenRowColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
