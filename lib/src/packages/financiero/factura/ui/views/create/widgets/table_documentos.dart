import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/datasorces/datatables/documentos_table_data_builder.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/blocs/item_documento/item_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class TableDocumentos extends StatelessWidget {
  final List<Documento> documentos;
  const TableDocumentos({super.key, required this.documentos});

  @override
  Widget build(BuildContext context) {
    late PlutoGridStateManager stateManager;
    final itemFacturaBloc = context.read<ItemDocumentoBloc>();
    final size = MediaQuery.of(context).size;
    final double rowHeight = size.height * 0.16;
    const double titleHeight = 48;
    const double columnFilterHeight = 36;

    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (context, state) {
        return Container(
          height: (rowHeight * 3) + (titleHeight + columnFilterHeight + 100),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: PlutoGrid(
            columns: DocumentosTableDataBuilder.buildColumns(context),
            rows: DocumentosTableDataBuilder.buildDataRows(documentos, context),
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              stateManager.setShowColumnFilter(true);
            },
            onRowDoubleTap: (event) => onRowDoubleTap(event, documentos, itemFacturaBloc, stateManager),
            onRowChecked: (event) => onRowChecked(event, documentos, itemFacturaBloc),
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                checkedColor: Theme.of(context).colorScheme.primaryContainer,
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

  void onRowDoubleTap(event, documentos, itemFacturaBloc, stateManager) {
    final Documento documento = documentos[event.rowIdx];
    if (event.row.checked!) {
      stateManager.setRowChecked(event.row, false);
      itemFacturaBloc.add(RemoveItemDocumentoEvent(documento: documento));
    } else {
      stateManager.setRowChecked(event.row, true);
      itemFacturaBloc.add(AddItemTransporteFacturaEvent(documento: documento));
    }
  }

  void onRowChecked(event, documentos, itemFacturaBloc) {
    if (event.isAll && event.isChecked != null) {
      for (final documento in documentos) {
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
