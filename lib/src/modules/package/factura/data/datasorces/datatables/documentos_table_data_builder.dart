import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';

class DocumentosTableDataBuilder {
  static List<PlutoColumn> buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'Item',
        field: 'item',
        type: PlutoColumnType.text(),
        enableRowChecked: true,
        minWidth: 88,
        width: 88,
        renderer: (renderContext) => buildFiledItem(renderContext, context),
      ),
      PlutoColumn(
        title: 'Alerts',
        field: 'alerts',
        type: PlutoColumnType.text(),
        minWidth: 48,
        width: 48,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        renderer: (renderContext) => buildFiledAlerts(renderContext, context),
      ),
      PlutoColumn(
        title: 'Documento',
        field: 'documento',
        hide: true,
        type: PlutoColumnType.number(),
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
        title: 'Flete',
        field: 'flete',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
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
        minWidth: 92,
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'Adiciones',
        field: 'adiciones',
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
        renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'Descuentos',
        field: 'descuentos',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
        type: PlutoColumnType.currency(name: '\$', decimalDigits: 0),
        renderer: (rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'R.C.P',
        field: 'rcp',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
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
        renderer: (rendererContext) => buildFieldAccion(rendererContext, context),
      ),
    ];
  }

  static List<PlutoRow> buildDataRows(List<Documento> documentos, BuildContext context) {
    final List<PlutoRow> dataRows = [];
    documentos.asMap().forEach((index, remesa) {
      double totalAdiciones = remesa.adiciones.fold(0, (total, adicion) => total + adicion.valor);
      double totalDescuentos = remesa.descuentos.fold(0, (total, descuento) => total + descuento.valor);

      Map<String, String> infoRemesaMap = {
        'remesa': "${remesa.impreso} (${remesa.remesa})",
        'centroCosto': remesa.cencosNombre,
        'tipo': remesa.tipoRemesa,
        'origen': remesa.origen,
        'destino': remesa.destino,
      };

      Map<String, dynamic> infoAlertsMap = {
        'anulacionTrafico': remesa.anulacionTrafico,
        'isDigitalizado': true,
      };

      Map<String, dynamic> obsMap = {
        'observacion': remesa.observacion,
        'remision': remesa.remision,
      };

      final Map<String, dynamic> dataColumn = {
        'item': index + 1,
        'alerts': jsonEncode(infoAlertsMap),
        'documento': remesa.remesa,
        'remesa': jsonEncode(infoRemesaMap),
        'obs': jsonEncode(obsMap),
        'flete': remesa.flete,
        'tarifaBase': remesa.flete,
        'adiciones': totalAdiciones,
        'descuentos': totalDescuentos,
        'rcp': remesa.rcp,
      };
      final row = TablePlutoGridDataSource.rowByColumns(buildColumns(context), dataColumn);
      dataRows.add(row);
    });
    return dataRows;
  }

  static Widget buildFiledItem(PlutoColumnRendererContext rendererContext, BuildContext context) {
    return BlocListener<ItemDocumentoBloc, ItemDocumentoState>(
      listener: (context, state) {
        List<ItemDocumento> itemDocumentos = state.itemDocumentos;
        final docuemnto = rendererContext.cell.row.cells["documento"]!.value;
        bool isPresent = itemDocumentos.any((pre) => pre.documento == docuemnto && pre.tipo == "TR");

        rendererContext.cell.row.setChecked(isPresent);
      },
      child: Container(
        width: 12,
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            rendererContext.cell.value.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  static Widget buildFiledAlerts(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final cellValue = rendererContext.cell.value.toString();
    Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final anulacionTrafico = remesaMap['anulacionTrafico'];
    final isDigitalizado = remesaMap['isDigitalizado'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isDigitalizado
            ? const Icon(
                Icons.image,
                color: Colors.green,
              )
            : const SizedBox(),
        anulacionTrafico
            ? Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
              )
            : const SizedBox(),
      ],
    );
  }

  static Widget buildFiledRemesa(PlutoColumnRendererContext rendererContext, BuildContext context) {
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
          const SizedBox(height: 4),
          _DetailRemesa(title: 'Tipo', subtitle: tipo, icon: Icons.fire_truck_outlined),
          const SizedBox(height: 4),
          _DetailRemesa(title: 'Origen', subtitle: origen, icon: Icons.crop_original),
          const SizedBox(height: 4),
          _DetailRemesa(title: 'Destino', subtitle: destino, icon: Icons.location_on_outlined),
        ],
      ),
    );
  }

  static Widget buildFiledObservaciones(rendererContext) {
    final cellValue = rendererContext.cell.value.toString();
    Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final obsRemesa = remesaMap['observacion'];
    final remision = remesaMap['remision'];
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 10, color: Colors.black),
              children: [
                const TextSpan(
                  text: 'Obs: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: CustomFunctions.limpiarTexto(obsRemesa),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            maxLines: 8,
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 10, color: Colors.black),
              children: [
                const TextSpan(
                  text: 'Remision: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: CustomFunctions.limpiarTexto(remision),
                ),
              ],
            ),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  static Widget buildFieldValuesCurrency(rendererContext, Color color) {
    return SelectableText(
      rendererContext.column.type.applyFormat(rendererContext.cell.value),
      style: TextStyle(color: color, fontSize: 12),
      textAlign: TextAlign.end,
    );
  }

  Padding divider(context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: double.infinity,
      ),
    );
  }

  static Widget buildFieldAccion(PlutoColumnRendererContext rendererContext, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSizeButton(
          onPressed: () {
            rendererContext.stateManager.removeRows([rendererContext.row]);
            final documentosAll = context.read<DocumentoBloc>().state.documentos;
            final documento = documentosAll[rendererContext.rowIdx];
            final List<Documento> documentos = List.from(documentosAll)..remove(documento);
            context.read<DocumentoBloc>().add(ChangedDocumentoEvent(documentos));
            context.read<ItemDocumentoBloc>().add(RemoveItemDocumentoEvent(documento: documento));
          },
          width: 32,
          icon: Icons.delete_outlined,
          color: Colors.red.shade800,
          iconColor: Colors.white,
        ),
        const SizedBox(width: 8),
        CustomSizeButton(width: 32, icon: Icons.refresh_outlined, onPressed: () {}),
      ],
    );
  }
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
