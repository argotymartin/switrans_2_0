import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/tables/table_pluto_grid_datasources.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';

class TableDocumentos extends StatelessWidget {
  const TableDocumentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        final double rowHeight = size.height * 0.16;
        const double titleHeight = 48;
        const double columnFilterHeight = 36;
        if (state is FacturaSuccesState) {
          late PlutoGridStateManager stateManager;
          final List<PlutoColumn> columns = ([
            PlutoColumn(
              title: 'Item',
              field: 'item',
              type: PlutoColumnType.text(),
              enableRowChecked: true,
              minWidth: 88,
              width: 80,
              renderer: (renderContext) => buildFiledItem(renderContext, Theme.of(context).colorScheme.primary),
            ),
            PlutoColumn(
              title: 'Remesa',
              field: 'remesa',
              applyFormatterInEditing: false,
              width: 240,
              minWidth: 240,
              type: PlutoColumnType.text(),
              renderer: (renderContext) => buildFiledRemesa(renderContext, context),
            ),
            PlutoColumn(
              title: 'Obs',
              field: 'obs',
              minWidth: 300,
              width: 300,
              type: PlutoColumnType.text(),
              renderer: buildFiledObservaciones,
            ),
            PlutoColumn(
              title: 'Adiciones',
              field: 'adiciones',
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              enableEditingMode: false,
              enableContextMenu: false,
              enableDropToResize: false,
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
              title: 'Descuentos',
              field: 'descuentos',
              enableEditingMode: false,
              enableContextMenu: false,
              enableDropToResize: false,
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
              title: 'Flete',
              field: 'flete',
              enableEditingMode: false,
              enableContextMenu: false,
              enableDropToResize: false,
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
                title: 'Tarifa Base',
                field: 'tarifaBase',
                enableEditingMode: false,
                enableContextMenu: false,
                enableDropToResize: false,
                type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
                renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
                footerRenderer: buildRenderSumFooter),
            PlutoColumn(
              title: 'R.C.P',
              field: 'rcp',
              enableEditingMode: false,
              enableContextMenu: false,
              enableDropToResize: false,
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade900),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
              title: 'Accion',
              field: 'accion',
              enableEditingMode: false,
              enableContextMenu: false,
              enableDropToResize: false,
              minWidth: 100,
              width: 120,
              type: PlutoColumnType.text(),
              renderer: buildFieldAccion,
            ),
          ]);

          List<Documento> remesasState = context.read<ItemFacturaBloc>().state.remesas;
          final dataRows = <PlutoRow>[];
          state.documentos.asMap().forEach((index, remesa) {
            bool isSelected = (remesasState.contains(remesa));
            int totalAdiciones = remesa.adiciones.fold(0, (total, adicion) => total + adicion.valor);
            int totalDescuentos = remesa.descuentos.fold(0, (total, descuento) => total + descuento.valor);
            Map<String, String> infoRemesa = {
              'remesa': "${remesa.impreso} (${remesa.remesa})",
              'centroCosto': remesa.cencosNombre,
              'tipo': remesa.tipoRemesa,
              'origen': remesa.origen,
              'destino': remesa.destino,
            };

            final Map<String, dynamic> dataColumn = {
              'item': index + 1,
              'remesa': jsonEncode(infoRemesa),
              'obs': remesa.observacion,
              'adiciones': totalAdiciones,
              'descuentos': totalDescuentos,
              'flete': remesa.flete,
              'tarifaBase': remesa.flete,
              'rcp': remesa.rcp,
            };

            final row = TablePlutoGridDataSource.rowByColumns(columns, isSelected, dataColumn);
            dataRows.add(row); // Agregamos la fila de datos a la lista
          });
          final List<PlutoRow> rows = dataRows.toList();
          return Container(
            height: (rowHeight * 3) + (titleHeight + columnFilterHeight + 100),
            padding: const EdgeInsets.all(15),
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                stateManager.setShowColumnFilter(true);
              },
              onRowDoubleTap: (event) {
                final Documento remesa = state.documentos[event.rowIdx];
                if (event.row.checked!) {
                  context.read<ItemFacturaBloc>().add(RemoveItemFacturaEvent(remesa: remesa));
                  stateManager.setRowChecked(event.row, false);
                } else {
                  stateManager.setRowChecked(event.row, true);
                  context.read<ItemFacturaBloc>().add(AddItemFacturaEvent(remesa: remesa));
                  context.read<FormFacturaBloc>().animationController.forward();
                }
              },
              onRowChecked: (event) {
                if (event.isAll && event.isChecked != null) {
                  for (final remesa in state.documentos) {
                    if (event.isChecked!) {
                      context.read<FormFacturaBloc>().animationController.forward();
                      context.read<ItemFacturaBloc>().add(AddItemFacturaEvent(remesa: remesa));
                    } else {
                      context.read<ItemFacturaBloc>().add(RemoveItemFacturaEvent(remesa: remesa));
                    }
                  }
                } else if (event.rowIdx != null && event.isChecked != null) {
                  final Documento remesa = state.documentos[event.rowIdx!];
                  if (event.isChecked!) {
                    context.read<ItemFacturaBloc>().add(AddItemFacturaEvent(remesa: remesa));
                    context.read<FormFacturaBloc>().animationController.forward();
                  } else {
                    context.read<ItemFacturaBloc>().add(RemoveItemFacturaEvent(remesa: remesa));
                  }
                }
              },
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
        }
        if (state is FacturaLoadingState) {
          return Center(child: Lottie.asset("animations/loading.json", height: 200));
        }
        return const SizedBox();
      },
    );
  }

  Widget buildRenderSumFooter(rendererContext) {
    return PlutoAggregateColumnFooter(
      rendererContext: rendererContext,
      type: PlutoAggregateColumnType.sum,
      format: '#,###',
      alignment: Alignment.center,
      titleSpanBuilder: (text) {
        return [
          TextSpan(text: text, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        ];
      },
    );
  }

  Widget buildFiledItem(rendererContext, Color color) {
    return Container(
      width: 12,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        //color: Theme.of(context).colorScheme.primary,
        color: color,
      ),
      child: Center(
        child: Text(
          rendererContext.cell.value.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildFieldValuesCurrency(rendererContext, Color color) {
    return SelectableText(
      rendererContext.column.type.applyFormat(rendererContext.cell.value),
      style: TextStyle(color: color, fontSize: 14),
      textAlign: TextAlign.end,
    );
  }

  Widget buildFiledObservaciones(rendererContext) {
    return SelectionArea(
      child: Text(
        textAlign: TextAlign.justify,
        CustomFunctions.limpiarTexto(rendererContext.row.cells[rendererContext.column.field]!.value.toString()),
        maxLines: 8,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget buildFiledRemesa(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final cellValue = rendererContext.cell.value.toString();
    Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final remesaText = remesaMap['remesa'];
    final centroCosto = remesaMap['centroCosto'];
    final tipo = remesaMap['tipo'];
    final origen = remesaMap['origen'];
    final destino = remesaMap['destino'];

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            remesaText,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _DetailRemesa(title: 'CC', subtitle: centroCosto, icon: Icons.monetization_on_outlined),
          divider(context),
          _DetailRemesa(title: 'Tipo', subtitle: tipo, icon: Icons.fire_truck_outlined),
          divider(context),
          _DetailRemesa(title: 'Origen', subtitle: origen, icon: Icons.crop_original),
          divider(context),
          _DetailRemesa(title: 'Destino', subtitle: destino, icon: Icons.location_on_outlined),
        ],
      ),
    );
  }

  Padding divider(context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 1,
      ),
    );
  }

  Widget buildFieldAccion(rendererContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete_forever_outlined,
            color: Colors.red,
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
      ],
    );
  }
}

class _DetailRemesa extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _DetailRemesa({
    required this.subtitle,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16),
        Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        Container(
          constraints: const BoxConstraints(maxWidth: 180),
          child: FittedBox(child: Text(subtitle, style: const TextStyle(color: Colors.black, fontSize: 10))),
        )
      ],
    );
  }
}
