import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class DocumentosTableDataBuilder {
  static List<PlutoColumn> buildColumns(BuildContext context) {
    return <PlutoColumn>[
      PlutoColumn(
        title: 'Item',
        field: 'item',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        type: PlutoColumnType.text(),
        enableRowChecked: true,
        minWidth: 88,
        width: 88,
        renderer: (PlutoColumnRendererContext renderContext) => buildFiledItem(renderContext, context),
      ),
      PlutoColumn(
        title: 'Alerts',
        field: 'alerts',
        type: PlutoColumnType.text(),
        minWidth: 88,
        width: 100,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        renderer: (PlutoColumnRendererContext renderContext) => buildFiledAlerts(renderContext, context),
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
        width: 240,
        minWidth: 240,
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext renderContext) => buildFiledRemesa(renderContext, context),
      ),
      PlutoColumn(
        title: 'Observación',
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
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'Tarifa Base',
        field: 'tarifaBase',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'Impuestos',
        field: 'impuestos',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 160,
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFiledImpuestos(rendererContext, context),
      ),
      PlutoColumn(
        title: 'Adiciones',
        field: 'adiciones',
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'Descuentos',
        field: 'descuentos',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
        footerRenderer: buildRenderSumFooter,
      ),
      PlutoColumn(
        title: 'R.C.P',
        field: 'rcp',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 92,
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade900),
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
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldAccion(rendererContext, context),
      ),
    ];
  }

  static List<PlutoRow> buildDataRows(List<Documento> documentos, BuildContext context) {
    final List<PlutoRow> dataRows = <PlutoRow>[];
    documentos.asMap().forEach((int index, Documento remesa) {
      final double totalAdiciones = remesa.adiciones.fold(0, (double total, Adicion adicion) => total + adicion.valor);
      final double totalDescuentos = remesa.descuentos.fold(0, (double total, Descuento descuento) => total + descuento.valor);

      final Map<String, String> infoRemesaMap = <String, String>{
        'remesa': "${remesa.impreso} (${remesa.remesa})",
        'centroCosto': remesa.cencosNombre,
        'tipo': remesa.tipoRemesa,
        'origen': remesa.origen,
        'destino': remesa.destino,
      };

      final Map<String, double> mapImpuestos = <String, double>{
        'iva': 190000,
        'reteiva': 7000,
        'retefuente': 30000,
        'reteica': 200,
      };

      final Map<String, dynamic> infoAlertsMap = <String, dynamic>{
        'anulacionTrafico': remesa.anulacionTrafico,
        'isDigitalizado': true,
      };

      final Map<String, dynamic> obsMap = <String, dynamic>{
        'observacion': remesa.observacion,
        'remision': remesa.remision,
      };

      final Map<String, dynamic> dataColumn = <String, dynamic>{
        'item': index + 1,
        'alerts': jsonEncode(infoAlertsMap),
        'documento': remesa.remesa,
        'remesa': jsonEncode(infoRemesaMap),
        'obs': jsonEncode(obsMap),
        'flete': remesa.flete,
        'tarifaBase': remesa.flete,
        'impuestos': jsonEncode(mapImpuestos),
        'adiciones': totalAdiciones,
        'descuentos': totalDescuentos,
        'rcp': remesa.rcp,
      };
      final PlutoRow row = TablePlutoGridDataSource.rowByColumns(buildColumns(context), dataColumn);
      dataRows.add(row);
    });
    return dataRows;
  }

  static Widget buildFiledItem(PlutoColumnRendererContext rendererContext, BuildContext context) {
    return BlocListener<ItemDocumentoBloc, ItemDocumentoState>(
      listener: (BuildContext context, ItemDocumentoState state) {
        final List<ItemDocumento> itemDocumentos = state.itemDocumentos;
        final int docuemnto = rendererContext.cell.row.cells["documento"]!.value;
        final bool isPresent = itemDocumentos.any((ItemDocumento pre) => pre.documento == docuemnto && pre.tipo == "TR");

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
    final String cellValue = rendererContext.cell.value.toString();
    final Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final bool anulacionTrafico = remesaMap['anulacionTrafico'];
    final bool isDigitalizado = remesaMap['isDigitalizado'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        isDigitalizado
            ? const Tooltip(
                message: 'Cuenta con documentos',
                child: Icon(
                  Icons.image,
                  color: Colors.blueGrey,
                ),
              )
            : const SizedBox(),
        anulacionTrafico
            ? Tooltip(
                message: 'Esta anulado por trafico',
                child: Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  static Widget buildFiledImpuestos(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final String cellValue = rendererContext.cell.value.toString();
    final Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final double iva = remesaMap['iva'];
    final double reteiva = remesaMap['reteiva'];
    final double retefuente = remesaMap['retefuente'];
    final double reteica = remesaMap['reteica'];
    final double total = iva + reteiva + reteica + retefuente;

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          _DetailRemesa(
            title: 'Iva',
            subtitle: "$iva",
          ),
          const SizedBox(height: 4),
          _DetailRemesa(title: 'Reteiva', subtitle: "$reteiva"),
          const SizedBox(height: 4),
          _DetailRemesa(title: 'Retefuente', subtitle: "$retefuente"),
          const SizedBox(height: 4),
          _DetailRemesa(title: 'Reteica', subtitle: "$reteica"),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              const Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              Container(
                constraints: const BoxConstraints(maxWidth: 180),
                child: FittedBox(
                  child: Text("$total", style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildFiledRemesa(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final String cellValue = rendererContext.cell.value.toString();
    final Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final String remesaText = remesaMap['remesa'];
    final String centroCosto = remesaMap['centroCosto'];
    final String tipo = remesaMap['tipo'];
    final String origen = remesaMap['origen'];
    final String destino = remesaMap['destino'];

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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

  static Widget buildFiledObservaciones(PlutoColumnRendererContext rendererContext) {
    final String cellValue = rendererContext.cell.value.toString();
    final Map<String, dynamic> remesaMap = jsonDecode(cellValue);
    final String obsRemesa = remesaMap['observacion'];
    final String remision = remesaMap['remision'];
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 10),
              children: <InlineSpan>[
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
              style: const TextStyle(fontSize: 10),
              children: <InlineSpan>[
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

  static Widget buildFieldValuesCurrency(PlutoColumnRendererContext rendererContext, Color color) {
    return SelectableText(
      rendererContext.column.type.applyFormat(rendererContext.cell.value),
      style: TextStyle(color: color, fontSize: 12),
      textAlign: TextAlign.end,
    );
  }

  static Widget buildFieldAccion(PlutoColumnRendererContext rendererContext, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomSizeButton(
          onPressed: () {
            rendererContext.stateManager.removeRows(<PlutoRow>[rendererContext.row]);

            final List<Documento> documentosAll = context.read<FormFacturaBloc>().state.documentos;
            final Documento documento = documentosAll[rendererContext.rowIdx];
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

Widget buildRenderSumFooter(PlutoColumnFooterRendererContext rendererContext) {
  return PlutoAggregateColumnFooter(
    rendererContext: rendererContext,
    type: PlutoAggregateColumnType.sum,
    alignment: Alignment.centerRight,
    titleSpanBuilder: (String text) {
      return <InlineSpan>[
        TextSpan(text: '\$ $text', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ];
    },
  );
}

class _DetailRemesa extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  const _DetailRemesa({
    required this.subtitle,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon != null ? Icon(icon, size: 16) : const SizedBox(),
        Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Container(
          constraints: const BoxConstraints(maxWidth: 180),
          child: FittedBox(child: Text(subtitle, style: const TextStyle(fontSize: 10))),
        ),
      ],
    );
  }
}
