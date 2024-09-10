import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class DocumentosTableDataBuilder {
  static List<PlutoColumn> buildColumns(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
    final EntryAutocomplete titleTipoDocumento = formFacturaBloc.state.entriesTiposDocumentos.firstWhere(
      (EntryAutocomplete element) => element.codigo == formFacturaBloc.request.documentoCodigo,
      orElse: () => EntryAutocomplete(title: ""),
    );
    return <PlutoColumn>[
      PlutoColumn(
        title: 'Item',
        field: 'item',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        type: PlutoColumnType.text(),
        enableRowChecked: true,
        minWidth: 110,
        width: 110,
        renderer: (PlutoColumnRendererContext renderContext) => buildFiledItem(renderContext, context),
        footerRenderer: (PlutoColumnFooterRendererContext context) =>
            buildRenderContadorFooter(context, formFacturaBloc.state.documentos.length, formFacturaBloc.state.documentosSelected.length),
      ),
      PlutoColumn(
        title: 'Documento',
        field: 'documento',
        hide: true,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: titleTipoDocumento.title,
        field: 'infoDocumento',
        width: 240,
        minWidth: 240,
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext renderContext) => buildFiledDocumento(renderContext, context),
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
        title: 'Valor Egreso',
        field: 'egreso',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 120,
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.red.shade700),
        footerRenderer: (PlutoColumnFooterRendererContext context) => buildRenderSumFooter(context, Colors.red.shade700),
      ),
      PlutoColumn(
        title: 'Valor Ingreso',
        field: 'ingreso',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 120,
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValuesCurrency(rendererContext, Colors.green.shade700),
        footerRenderer: (PlutoColumnFooterRendererContext context) => buildRenderSumFooter(context, Colors.green.shade700),
      ),
      PlutoColumn(
        title: 'Adiciones',
        field: 'adiciones',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 120,
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldAdicion(rendererContext, context),
        footerRenderer: buildRenderSumAdicionesFooter,
      ),
      PlutoColumn(
        title: 'Descuentos',
        field: 'descuentos',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 120,
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldDescuento(rendererContext, context),
        footerRenderer: buildRenderSumDescuentosFooter,
      ),
      PlutoColumn(
        title: 'Impuestos',
        field: 'impuestos',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 200,
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFiledImpuestos(rendererContext, context),
      ),
      PlutoColumn(
        title: 'Total',
        field: 'total',
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        minWidth: 120,
        type: PlutoColumnType.currency(name: r'$', decimalDigits: 0),
        renderer: (PlutoColumnRendererContext rendererContext) => buildFieldValueTotal(rendererContext, Colors.green.shade900),
        footerRenderer: (PlutoColumnFooterRendererContext context) => buildRenderSumFooter(context, Colors.green.shade900),
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
    documentos.asMap().forEach((int index, Documento documento) {
      final Map<String, dynamic> itemMap = <String, dynamic>{
        'item': index + 1,
        'isAnulacion': documento.isAnulacion,
      };

      final Map<String, dynamic> dataAdiciones = <String, dynamic>{
        for (final Adicion adicion in documento.adiciones) adicion.nombre: adicion.valor,
      };

      final Map<String, dynamic> dataDescuentos = <String, dynamic>{
        for (final Descuento descuento in documento.descuentos) descuento.nombre: descuento.valor,
      };

      final Map<String, String> infoDocumentoMap = <String, String>{
        'documento': "${documento.impreso} (${documento.documento})",
        'centroCosto': documento.centroCostoNombre,
        'tipo': documento.tipoDocumentoNombre,
        'origen': documento.origen,
        'destino': documento.destino,
      };
      final List<Map<String, dynamic>> mapImpuestos = documento.impuestos.map((Impuesto e) {
        return <String, double>{e.nombre: e.valor};
      }).toList();

      final Map<String, dynamic> obsMap = <String, dynamic>{
        'observacion': documento.descripcion,
        'datosAdicionales': documento.datosAdicionales,
      };

      final Map<String, dynamic> dataColumn = <String, dynamic>{
        'item': jsonEncode(itemMap),
        'documento': documento.documento,
        'infoDocumento': jsonEncode(infoDocumentoMap),
        'obs': jsonEncode(obsMap),
        'egreso': documento.valorEgreso,
        'ingreso': documento.valorIngreso,
        'impuestos': jsonEncode(mapImpuestos),
        'adiciones': jsonEncode(dataAdiciones),
        'descuentos': jsonEncode(dataDescuentos),
        'total': documento.valorTotal,
      };
      final PlutoRow row = TablePlutoGridDataSource.rowByColumns(buildColumns(context), dataColumn);
      dataRows.add(row);
    });
    return dataRows;
  }

  static Widget buildFiledItem(PlutoColumnRendererContext rendererContext, BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        final String cellValue = rendererContext.cell.value.toString();
        final dynamic documentoMap = jsonDecode(cellValue);
        final int item = documentoMap["item"];
        final bool isAnulacion = documentoMap["isAnulacion"];
        final List<Documento> itemDocumentos = state.documentosSelected;
        final int documento = rendererContext.cell.row.cells["documento"]!.value;
        final bool isPresent = itemDocumentos.any((Documento element) => element.documento == documento);
        rendererContext.cell.row.setChecked(isPresent);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isAnulacion
                ? Center(
                    child: Lottie.asset(
                      'assets/animations/warning.json',
                      height: 48,
                      width: 48,
                      fit: BoxFit.contain,
                    ),
                  )
                : const SizedBox(),
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  "$item",
                  style: TextStyle(color: AppTheme.colorThemePrimary),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget buildFiledImpuestos(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final String cellValue = rendererContext.cell.value.toString();
    final dynamic documentoMap = jsonDecode(cellValue);
    final List<TableRow> children = <TableRow>[];
    for (final dynamic mapa in documentoMap) {
      mapa.forEach((String key, dynamic value) {
        children.add(
          TableRow(
            children: <Widget>[
              buildCellContent(Text(key, style: const TextStyle(fontSize: 12))),
              buildCellContent(
                CurrencyLabel(
                  text: '${value.toInt()}',
                  color: key == "IVA" ? Colors.green.shade800 : Colors.red.shade800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      });
    }

    return Center(
      child: Table(
        border: TableBorder.all(
          color: Theme.of(context).colorScheme.primaryFixedDim,
          borderRadius: BorderRadius.circular(8),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiaryContainer),
            children: <Widget>[
              buldTitleCell("Nombre", Colors.black),
              buldTitleCell("Valor", Colors.black),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

  static TableCell buildCellContent(Widget child) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: child,
      ),
    );
  }

  static TableCell buldTitleCell(String title, Color color) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }

  static Widget buildFiledDocumento(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final String cellValue = rendererContext.cell.value.toString();
    final Map<String, dynamic> documentoMap = jsonDecode(cellValue);
    final String documentoText = documentoMap['documento'];
    final String centroCosto = documentoMap['centroCosto'];
    final String tipo = documentoMap['tipo'];
    final String origen = documentoMap['origen'];
    final String destino = documentoMap['destino'];

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            documentoText,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _DetailDocumento(title: 'CC', subtitle: centroCosto, icon: Icons.monetization_on_outlined),
          const SizedBox(height: 4),
          tipo.isNotEmpty ? _DetailDocumento(title: 'Tipo', subtitle: tipo, icon: Icons.fire_truck_outlined) : const SizedBox(),
          const SizedBox(height: 4),
          origen.isNotEmpty ? _DetailDocumento(title: 'Origen', subtitle: origen, icon: Icons.crop_original) : const SizedBox(),
          const SizedBox(height: 4),
          destino.isNotEmpty ? _DetailDocumento(title: 'Destino', subtitle: destino, icon: Icons.location_on_outlined) : const SizedBox(),
        ],
      ),
    );
  }

  static Widget buildFiledObservaciones(PlutoColumnRendererContext rendererContext) {
    final String cellValue = rendererContext.cell.value.toString();
    final Map<String, dynamic> documentoMap = jsonDecode(cellValue);
    final String obsDocumento = documentoMap['observacion'];
    final String datosAdicionales = documentoMap['datosAdicionales'];
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Obs: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.colorTextTheme),
                  ),
                  TextSpan(
                    style: TextStyle(color: AppTheme.colorTextTheme),
                    text: CustomFunctions.limpiarTexto(obsDocumento),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              maxLines: 8,
            ),
            const SizedBox(height: 4),
            datosAdicionales.isNotEmpty
                ? RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Datos Adicionales: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.colorTextTheme),
                        ),
                        TextSpan(
                          style: TextStyle(color: AppTheme.colorTextTheme),
                          text: CustomFunctions.limpiarTexto(datosAdicionales),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  static Widget buildFieldValuesCurrency(PlutoColumnRendererContext rendererContext, Color color) {
    return SelectableText(
      rendererContext.column.type.applyFormat(rendererContext.cell.value),
      style: TextStyle(color: color, fontSize: 16),
      textAlign: TextAlign.end,
    );
  }

  static Widget buildFieldAdicion(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final Map<String, dynamic> adicionesMap = jsonDecode(rendererContext.cell.value.toString());
    final double totalAdiciones = adicionesMap.values.fold(0.0, (double total, dynamic value) => total + value);
    final int documento = rendererContext.cell.row.cells["documento"]!.value;
    return InkWell(
      onTap: () {
        showDataAdicionesAndDescuentos(context, adicionesMap, "Adiciones: $documento", Colors.green.shade800);
      },
      child: SizedBox(
        width: 100,
        height: 140,
        child: CurrencyLabel(text: '${totalAdiciones.toInt()}', color: Colors.green.shade800),
      ),
    );
  }

  static Widget buildFieldDescuento(PlutoColumnRendererContext rendererContext, BuildContext context) {
    final Map<String, dynamic> descuentoMap = jsonDecode(rendererContext.cell.value.toString());
    final double totalAdiciones = descuentoMap.values.fold(0.0, (double total, dynamic value) => total + value);
    final int documento = rendererContext.cell.row.cells["documento"]!.value;
    return InkWell(
      onTap: () {
        showDataAdicionesAndDescuentos(context, descuentoMap, "Descuentos: $documento", Colors.red.shade800);
      },
      child: SizedBox(
        width: 100,
        height: 140,
        child: CurrencyLabel(text: '${totalAdiciones.toInt()}', color: Colors.red.shade800),
      ),
    );
  }

  static Widget buildFieldValueTotal(PlutoColumnRendererContext rendererContext, Color color) {
    return Tooltip(
      message: "(Valor Ingreso + Adiciones - Descuentos) + IVA - (Retefuente + Reteica + Reteiva)",
      padding: const EdgeInsets.all(8),
      child: SelectableText(
        rendererContext.column.type.applyFormat(rendererContext.cell.value),
        style: TextStyle(color: color, fontSize: 16),
        textAlign: TextAlign.end,
      ),
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
            context.read<FormFacturaBloc>().add(RemoveDocumentoFormFacturaEvent(documento));
          },
          size: 32,
          icon: Icons.delete_outlined,
          color: Colors.red,
          iconColor: Colors.white,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

Widget buildRenderSumFooter(PlutoColumnFooterRendererContext rendererContext, Color color) {
  return PlutoAggregateColumnFooter(
    rendererContext: rendererContext,
    type: PlutoAggregateColumnType.sum,
    alignment: Alignment.centerRight,
    titleSpanBuilder: (String text) {
      return <InlineSpan>[
        TextSpan(text: '\$ $text', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
      ];
    },
  );
}

Widget buildRenderSumAdicionesFooter(PlutoColumnFooterRendererContext rendererContext) {
  return BlocBuilder<FormFacturaBloc, FormFacturaState>(
    builder: (BuildContext context, FormFacturaState state) {
      final double totalAdiciones = state.documentos.fold(0.0, (double total, Documento documento) {
        return total + documento.adiciones.fold(0.0, (num totalAdicion, Adicion adicion) => totalAdicion + (adicion.valor));
      });
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CurrencyLabel(
          text: '${totalAdiciones.toInt()}',
          color: Colors.green.shade800,
          fontWeight: FontWeight.bold,
        ),
      );
    },
  );
}

Widget buildRenderSumDescuentosFooter(PlutoColumnFooterRendererContext rendererContext) {
  return BlocBuilder<FormFacturaBloc, FormFacturaState>(
    builder: (BuildContext context, FormFacturaState state) {
      final double totalDescuentos = state.documentos.fold(0.0, (double total, Documento documento) {
        return total + documento.descuentos.fold(0.0, (num totalDescuento, Descuento descuento) => totalDescuento + (descuento.valor));
      });
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CurrencyLabel(
          text: '${totalDescuentos.toInt()}',
          color: Colors.red.shade800,
          fontWeight: FontWeight.bold,
        ),
      );
    },
  );
}

Widget buildRenderContadorFooter(PlutoColumnFooterRendererContext rendererContext, int documentos, int selected) {
  return Center(child: Text("$documentos/$selected", style: const TextStyle(fontSize: 14)));
}

class _DetailDocumento extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  const _DetailDocumento({
    required this.subtitle,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            icon != null ? Icon(icon, size: 16) : const SizedBox(),
            Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            Container(
              constraints: const BoxConstraints(maxWidth: 180),
              child: FittedBox(child: Text(subtitle, style: const TextStyle(fontSize: 12))),
            ),
          ],
        ),
      ],
    );
  }
}

void showDataAdicionesAndDescuentos(BuildContext context, Map<String, dynamic> data, String title, Color color) {
  final List<TableRow> children = <TableRow>[];
  double total = 0;
  data.forEach((String key, dynamic value) {
    total += value;
    children.add(
      TableRow(
        children: <Widget>[
          DocumentosTableDataBuilder.buildCellContent(Text(key, style: const TextStyle(fontSize: 12))),
          DocumentosTableDataBuilder.buildCellContent(CurrencyLabel(text: '${value.toInt()}', color: color, fontSize: 14)),
        ],
      ),
    );
  });

  children.add(
    TableRow(
      children: <Widget>[
        DocumentosTableDataBuilder.buildCellContent(const Text("Total", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
        DocumentosTableDataBuilder.buildCellContent(
          CurrencyLabel(text: '${total.toInt()}', color: color, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text(title),
      content: Container(
        padding: const EdgeInsets.all(16),
        width: 360,
        child: SingleChildScrollView(
          child: Center(
            child: Table(
              border: TableBorder.all(color: Theme.of(context).colorScheme.primaryFixedDim),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
                  children: <Widget>[
                    DocumentosTableDataBuilder.buldTitleCell("Nombre", Colors.black),
                    DocumentosTableDataBuilder.buldTitleCell("Valor", Colors.black),
                  ],
                ),
                ...children,
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
      ],
    ),
  );
}
