import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/config/config.dart';
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
    const double rowHeight = 56;
    const double titleHeight = 48;
    const double footerHeight = 96;
    const double scrollbarThickness = 16;
    final int pageSize = rows.length >= 9 ? 10 : rows.length;
    final double columnFilterHeight = columnFilter ? 36 : 0;
    final double totalWidth = columns.fold(0, (double sum, PlutoColumn element) => sum + element.width);
    final double width = MediaQuery.of(context).size.width - kWidthSidebar - 48;
    return Container(
      height: (rowHeight * pageSize) + (titleHeight + columnFilterHeight + scrollbarThickness + footerHeight),
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
        createFooter: (PlutoGridStateManager stateManager) {
          stateManager.setPageSize(pageSize, notify: false);
          return PlutoPagination(stateManager);
        },
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
                  activatedColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8),
                  gridBackgroundColor: AppTheme.colorThemePrimary,
                  activatedBorderColor: Colors.transparent,
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
          columnSize: PlutoGridColumnSizeConfig(autoSizeMode: totalWidth <= width ? PlutoAutoSizeMode.scale : PlutoAutoSizeMode.none),
          scrollbar: const PlutoGridScrollbarConfig(
            longPressDuration: Duration.zero,
            scrollbarThickness: scrollbarThickness,
            isAlwaysShown: true,
            enableScrollAfterDragEnd: false,
            scrollbarRadius: Radius.circular(20),
            scrollbarThicknessWhileDragging: scrollbarThickness,
          ),
          localeText: const PlutoGridLocaleText.spanish(),
        ),
      ),
    );
  }
}
