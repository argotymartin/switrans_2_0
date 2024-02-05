import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/tables/table_pluto_grid_datasources.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';

class TableRemesas extends StatelessWidget {
  const TableRemesas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (context, state) {
        if (state is FacturaSuccesState) {
          late PlutoGridStateManager stateManager;
          final List<PlutoColumn> columns = ([
            PlutoColumn(
              title: 'Item',
              field: 'item',
              suppressedAutoSize: true,
              type: PlutoColumnType.text(),
              enableRowDrag: true,
              enableRowChecked: true,
              minWidth: 120,
              width: 124,
              renderer: (renderContext) => buildFiledItem(renderContext, Theme.of(context).colorScheme.primary),
            ),
            PlutoColumn(
              title: 'Remesa',
              field: 'remesa',
              width: 160,
              minWidth: 160,
              type: PlutoColumnType.text(),
              renderer: buildFiledRemesa,
            ),
            PlutoColumn(
              title: 'Obs',
              field: 'obs',
              minWidth: 220,
              width: 250,
              type: PlutoColumnType.text(),
              renderer: buildFiledObserrvaciones,
            ),
            PlutoColumn(
              title: 'Adiciones',
              field: 'adiciones',
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              enableEditingMode: true,
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
              title: 'Descuentos',
              field: 'descuentos',
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
              title: 'Flete',
              field: 'flete',
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
                title: 'Tarifa Base',
                field: 'tarifaBase',
                type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
                renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
                footerRenderer: buildRenderSumFooter),
            PlutoColumn(
              title: 'R.C.P',
              field: 'rcp',
              type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
              renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade900),
              footerRenderer: buildRenderSumFooter,
            ),
            PlutoColumn(
              title: 'Accion',
              field: 'accion',
              minWidth: 120,
              type: PlutoColumnType.text(),
              renderer: buildFieldAccion,
            ),
          ]);

          List<Documento> remesasState = context.read<ItemFacturaBloc>().state.remesas;

          final dataRows = <PlutoRow>[];

          state.remesas.asMap().forEach((index, remesa) {
            bool isSelected = false;
            if (remesasState.contains(remesa)) {
              isSelected = true;
            }
            final Map<String, dynamic> dataColumn = {
              'item': index + 1, // Asignamos el valor del índice más 1 como 'item'
              'remesa': "${remesa.remesa} CC: ${remesa.cencosNombre} Tipo: ${remesa.tipoRemesa}",
              'obs': remesa.observacion,
              'adiciones': remesa.adiciones,
              'descuentos': remesa.descuentos,
              'flete': remesa.flete,
              'tarifaBase': remesa.flete,
              'rcp': remesa.rcp,
            };

            final row = TablePlutoGridDataSource.rowByColumns(columns, isSelected, dataColumn);
            dataRows.add(row); // Agregamos la fila de datos a la lista
          });
          final List<PlutoRow> rows = dataRows.toList();
          return Container(
            height: (120 * 3) + (48 + 60 + 80),
            padding: const EdgeInsets.all(15),
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                stateManager.setShowColumnFilter(true);
              },
              onChanged: (PlutoGridOnChangedEvent event) {},
              onRowChecked: (event) {
                if (event.isAll && event.isChecked != null) {
                  for (final remesa in state.remesas) {
                    if (event.isChecked!) {
                      context.read<FormFacturaBloc>().animationController.forward();
                      context.read<ItemFacturaBloc>().add(AddItemFacturaEvent(remesa: remesa));
                    } else {
                      context.read<ItemFacturaBloc>().add(RemoveItemFacturaEvent(remesa: remesa));
                    }
                  }
                } else if (event.rowIdx != null && event.isChecked != null) {
                  final Documento remesa = state.remesas[event.rowIdx!];
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
                  activatedBorderColor: Theme.of(context).colorScheme.primary,
                  columnHeight: 48,
                  columnFilterHeight: 60,
                  rowHeight: 120,
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
      //filter: (cell) => cell.row.checked == true,
      rendererContext: rendererContext,
      type: PlutoAggregateColumnType.sum,
      format: '#,###',
      alignment: Alignment.center,
      titleSpanBuilder: (text) {
        return [
          const TextSpan(
            text: 'Total',
            style: TextStyle(color: Colors.grey),
          ),
          const TextSpan(text: ' : '),
          TextSpan(text: text),
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
    return Text(
      rendererContext.column.type.applyFormat(rendererContext.cell.value),
      style: TextStyle(color: color, fontSize: 14),
      textAlign: TextAlign.end,
    );
  }

  Widget buildFiledObserrvaciones(rendererContext) {
    return Text(
      rendererContext.row.cells[rendererContext.column.field]!.value.toString(),
      maxLines: 8,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 10),
    );
  }

  Widget buildFiledRemesa(rendererContext) {
    final cellValue = rendererContext.cell.value.toString();
    final valRemesa = cellValue.split("CC:")[0];
    final valAdicional = cellValue.split("CC:")[1].trim(); // Trim para eliminar espacios adicionales

    final ccParts = valAdicional.split("Tipo:");
    final cc = ccParts[0].trim(); // Trim para eliminar espacios adicionales
    final tipo = ccParts[1].trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          valRemesa,
        ),
        Row(
          children: [
            const Icon(Icons.monetization_on_outlined, size: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12),
                children: [
                  const TextSpan(
                    text: 'CC: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(text: cc, style: const TextStyle(color: Colors.black))
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.fire_truck_outlined, size: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12),
                children: [
                  const TextSpan(
                    text: 'Tipo: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(text: tipo, style: const TextStyle(color: Colors.black))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFieldAccion(rendererContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
