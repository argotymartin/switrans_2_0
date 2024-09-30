import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/documentos_table_data_builder.dart';
import 'package:switrans_2_0/src/util/shared/widgets/labels/currency_label.dart';

class TableDocumentos extends StatelessWidget {
  final List<Documento> documentos;
  const TableDocumentos({
    required this.documentos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late PlutoGridStateManager stateManager;
    final FacturaBloc facturaBloc = context.read<FacturaBloc>();
    const double rowHeight = 160;
    const double titleHeight = 48;
    const double columnFilterHeight = 36;
    final int tableHigth = documentos.length >= 3 ? 3 : documentos.length;

    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        return Container(
          height: (rowHeight * tableHigth) + (titleHeight + columnFilterHeight + 86),
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
              facturaBloc: facturaBloc,
              stateManager: stateManager,
              context: context,
            ),
            onRowChecked: (PlutoGridOnRowCheckedEvent event) => onRowChecked(
              event: event,
              documentos: documentos,
              facturaBloc: facturaBloc,
              stateManager: stateManager,
              context: context,
            ),
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                gridBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                rowColor: AppTheme.colorThemeSecundary,
                oddRowColor: Theme.of(context).colorScheme.surfaceContainerLow,
                borderColor: Theme.of(context).colorScheme.primaryFixedDim,
                gridBorderColor: Theme.of(context).colorScheme.primaryFixedDim,
                columnTextStyle: TextStyle(color: Theme.of(context).colorScheme.inverseSurface, fontSize: 16, fontWeight: FontWeight.bold),
                checkedColor: Theme.of(context).colorScheme.secondaryContainer,
                activatedColor: Theme.of(context).colorScheme.onPrimary,
                activatedBorderColor: Theme.of(context).colorScheme.onPrimaryContainer,
                columnHeight: titleHeight,
                columnFilterHeight: columnFilterHeight,
                rowHeight: rowHeight,
                gridBorderRadius: BorderRadius.circular(16),
              ),
              columnSize: const PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.scale),
              scrollbar: const PlutoGridScrollbarConfig(
                isAlwaysShown: true,
                longPressDuration: Duration.zero,
                onlyDraggingThumb: false,
                scrollbarThickness: 12,
                mainAxisMargin: 5,
                crossAxisMargin: 2,
                scrollbarRadius: Radius.circular(4),
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
    required FacturaBloc facturaBloc,
    required PlutoGridStateManager stateManager,
    required BuildContext context,
  }) {
    final Documento documento = documentos[event.rowIdx];
    if (event.row.checked!) {
      stateManager.setRowChecked(event.row, false);
      facturaBloc.add(RemoveDocumentoFacturaEvent(documento));
    } else {
      if (documento.valorEgreso > documento.valorIngreso) {
        showErrorIngresoVSEgresoDialog(context, <Documento>[documento]);
        facturaBloc.add(AddDocumentoFacturaEvent(documento));
      } else if (documento.isAnulacion) {
        stateManager.setRowChecked(event.row, false);
        showErrorAnulacionDialog(context, documento);
      } else {
        stateManager.setRowChecked(event.row, true);
        facturaBloc.add(AddDocumentoFacturaEvent(documento));
      }
    }
  }

  void onRowChecked({
    required PlutoGridOnRowCheckedEvent event,
    required List<Documento> documentos,
    required FacturaBloc facturaBloc,
    required PlutoGridStateManager stateManager,
    required BuildContext context,
  }) {
    final List<Documento> documentosEgresoVsIngreso = <Documento>[];
    if (event.isAll) {
      for (final Documento documento in documentos) {
        if (event.isChecked!) {
          if (documento.valorEgreso > documento.valorIngreso) {
            documentosEgresoVsIngreso.add(documento);
            facturaBloc.add(AddDocumentoFacturaEvent(documento));
          } else if (documento.isAnulacion) {
            showErrorAnulacionDialog(context, documento);
          } else {
            facturaBloc.add(AddDocumentoFacturaEvent(documento));
          }
        } else {
          facturaBloc.add(RemoveDocumentoFacturaEvent(documento));
        }
      }
    } else if (event.rowIdx != null && event.isChecked != null) {
      final Documento documento = documentos[event.rowIdx!];
      if (event.isChecked!) {
        if (documento.valorEgreso > documento.valorIngreso) {
          documentosEgresoVsIngreso.add(documento);
          facturaBloc.add(AddDocumentoFacturaEvent(documento));
        } else if (documento.isAnulacion) {
          stateManager.setRowChecked(event.row!, false);
          showErrorAnulacionDialog(context, documento);
        } else {
          facturaBloc.add(AddDocumentoFacturaEvent(documento));
        }
      } else {
        facturaBloc.add(RemoveDocumentoFacturaEvent(documento));
      }
    }

    if (documentosEgresoVsIngreso.isNotEmpty) {
      showErrorIngresoVSEgresoDialog(context, documentosEgresoVsIngreso);
    }
  }
}

void showErrorIngresoVSEgresoDialog(BuildContext context, List<Documento> documentos) {
  final Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: SizedBox(
        width: size.width * 0.3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Lottie.asset(
                  'assets/animations/alert-orange.json',
                  height: 96,
                  width: 96,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Novedad: ',
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Se encontraron documentos con valores de egreso mayores a los valores del ingreso",
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Los documentos que presentan esta novedad son los siguientes: ",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 18),
              ),
              const SizedBox(height: 32),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    children: <Widget>[
                      const Row(
                        children: <Widget>[
                          Expanded(child: _DataCell(isTitle: true, text: "Documento")),
                          Expanded(child: _DataCell(isTitle: true, text: "Ingreso")),
                          Expanded(child: _DataCell(isTitle: true, text: "Egreso")),
                        ],
                      ),
                      ...documentos.map((Documento element) {
                        return Row(
                          children: <Widget>[
                            Expanded(child: _DataCell(text: "${element.documento}")),
                            Expanded(child: _DataCell(text: "${element.valorIngreso.toInt()}", isCurrency: true)),
                            Expanded(child: _DataCell(text: "${element.valorEgreso.toInt()}", isCurrency: true)),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
      ],
    ),
  );
}

class _DataCell extends StatelessWidget {
  final String text;
  final bool isTitle;
  final bool isCurrency;
  const _DataCell({
    required this.text,
    this.isTitle = false,
    this.isCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isTitle ? const Color(0xffF8CE12) : Colors.transparent,
        border: Border.all(color: Colors.grey),
      ),
      child: isCurrency
          ? CurrencyLabel(color: Colors.black, text: text)
          : Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}

void showErrorAnulacionDialog(BuildContext context, Documento documento) {
  final Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: SizedBox(
        width: size.width * 0.3,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Lottie.asset(
                'assets/animations/warning.json',
                height: 96,
                width: 96,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "El documento: ",
                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
                  ),
                  Text(
                    "${documento.documento} ",
                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "Esta vinculado a un despacho no realizado",
                style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
              ),
              const SizedBox(height: 32),
              Text(
                "No es posible facturar este documento",
                style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 20, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
      ],
    ),
  );
}
