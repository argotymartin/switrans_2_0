import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/datasources/datatables/documentos_table_data_builder.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/blocs/item_documento/item_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';

class TableDocumentos extends StatelessWidget {
  final List<Documento> documentos;
  const TableDocumentos({
    required this.documentos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late PlutoGridStateManager stateManager;
    final ItemDocumentoBloc itemFacturaBloc = context.read<ItemDocumentoBloc>();
    final Size size = MediaQuery.of(context).size;
    final double rowHeight = size.height * 0.16;
    const double titleHeight = 48;
    const double columnFilterHeight = 36;
    final int tableHigth = documentos.length >= 3 ? 3 : documentos.length;

    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        return Container(
          height: (rowHeight * tableHigth) + (titleHeight + columnFilterHeight + 84),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: PlutoGrid(
            columns: DocumentosTableDataBuilder.buildColumns(context),
            rows: DocumentosTableDataBuilder.buildDataRows(documentos, context),
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              stateManager.setShowColumnFilter(true);
            },
            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) => onRowDoubleTap(
              event: event,
              documentos: documentos,
              itemFacturaBloc: itemFacturaBloc,
              stateManager: stateManager,
            ),
            onRowChecked: (PlutoGridOnRowCheckedEvent event) => onRowChecked(
              event: event,
              documentos: documentos,
              itemFacturaBloc: itemFacturaBloc,
            ),
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                gridBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                rowColor: AppTheme.colorThemeSecundary,
                oddRowColor: Theme.of(context).colorScheme.surfaceContainerLow,
                borderColor: Theme.of(context).colorScheme.primaryFixedDim,
                gridBorderColor: Theme.of(context).colorScheme.primaryFixedDim,
                columnTextStyle: TextStyle(color: Theme.of(context).colorScheme.inverseSurface, fontSize: 16, fontWeight: FontWeight.bold),
                checkedColor: Theme.of(context).colorScheme.surface,
                activatedColor: Theme.of(context).colorScheme.onPrimary,
                activatedBorderColor: Theme.of(context).colorScheme.onPrimaryContainer,
                columnHeight: titleHeight,
                columnFilterHeight: columnFilterHeight,
                rowHeight: rowHeight,
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
      },
    );
  }

  void onRowDoubleTap({
    required PlutoGridOnRowDoubleTapEvent event,
    required List<Documento> documentos,
    required ItemDocumentoBloc itemFacturaBloc,
    required PlutoGridStateManager stateManager,
  }) {
    final Documento documento = documentos[event.rowIdx];
    if (event.row.checked!) {
      stateManager.setRowChecked(event.row, false);
      itemFacturaBloc.add(RemoveItemDocumentoEvent(documento: documento));
    } else {
      stateManager.setRowChecked(event.row, true);
      itemFacturaBloc.add(AddItemTransporteFacturaEvent(documento: documento));
    }
  }

  void onRowChecked({
    required PlutoGridOnRowCheckedEvent event,
    required List<Documento> documentos,
    required ItemDocumentoBloc itemFacturaBloc,
  }) {
    if (event.isAll && event.isChecked != null) {
      for (final Documento documento in documentos) {
        if (event.isChecked!) {
          itemFacturaBloc.add(AddItemTransporteFacturaEvent(documento: documento));
        } else {
          itemFacturaBloc.add(RemoveItemDocumentoEvent(documento: documento));
        }
      }
    } else if (event.rowIdx != null && event.isChecked != null) {
      final Documento documento = documentos[event.rowIdx!];
      if (event.isChecked!) {
        itemFacturaBloc.add(AddItemTransporteFacturaEvent(documento: documento));
      } else {
        itemFacturaBloc.add(RemoveItemDocumentoEvent(documento: documento));
      }
    }
  }
}
