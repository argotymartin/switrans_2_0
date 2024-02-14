import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/datasorces/datatables/documentos_table_data_builder.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/models/pre_factura_model.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';

class TableDocumentos extends StatelessWidget {
  const TableDocumentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemFacturaBloc = context.read<ItemFacturaBloc>();
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        final double rowHeight = size.height * 0.16;
        const double titleHeight = 48;
        const double columnFilterHeight = 36;
        if (state is FacturaSuccesState) {
          late PlutoGridStateManager stateManager;
          final List<PlutoColumn> columns = DocumentosTableDataBuilder.buildColumns(context);
          final List<PlutoRow> dataRows = DocumentosTableDataBuilder.buildDataRows(state.documentos, context);
          return BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
            builder: (context, itemstate) {
              return Container(
                height: (rowHeight * 3) + (titleHeight + columnFilterHeight + 100),
                padding: const EdgeInsets.all(15),
                child: PlutoGrid(
                  columns: columns,
                  rows: dataRows,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    stateManager.setShowColumnFilter(true);
                  },
                  onRowDoubleTap: (event) => onRowDoubleTap(event, state.documentos, itemFacturaBloc, stateManager),
                  onRowChecked: (event) => onRowChecked(event, state.documentos, itemFacturaBloc),
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
        if (state is FacturaLoadingState) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/animations/loading.gif"),
                const Text("Por favor espere........."),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void onRowDoubleTap(event, documentos, itemFacturaBloc, stateManager) {
    final Documento doc = documentos[event.rowIdx];
    final prefactura = PreFacturaModel.toDocumetno(doc);
    if (event.row.checked!) {
      stateManager.setRowChecked(event.row, false);
      itemFacturaBloc.add(RemoveItemFacturaEvent(preFactura: prefactura));
    } else {
      stateManager.setRowChecked(event.row, true);
      itemFacturaBloc.add(AddItemTransporteFacturaEvent(preFactura: prefactura));
    }
  }

  void onRowChecked(event, documentos, itemFacturaBloc) {
    if (event.isAll && event.isChecked != null) {
      for (final remesa in documentos) {
        final prefactura = PreFacturaModel.toDocumetno(remesa);
        if (event.isChecked!) {
          itemFacturaBloc.add(AddItemTransporteFacturaEvent(preFactura: prefactura));
        } else {
          itemFacturaBloc.add(RemoveItemFacturaEvent(preFactura: prefactura));
        }
      }
    } else if (event.rowIdx != null && event.isChecked != null) {
      final Documento doc = documentos[event.rowIdx!];
      final prefactura = PreFacturaModel.toDocumetno(doc);
      if (event.isChecked!) {
        itemFacturaBloc.add(AddItemTransporteFacturaEvent(preFactura: prefactura));
      } else {
        itemFacturaBloc.add(RemoveItemFacturaEvent(preFactura: prefactura));
      }
    }
  }
}
