import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/documentos_table_data_builder.dart';

class TableDocumentos extends StatelessWidget {
  final List<Documento> documentos;
  const TableDocumentos({
    required this.documentos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late PlutoGridStateManager stateManager;
    final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
    const double rowHeight = 160;
    const double titleHeight = 48;
    const double columnFilterHeight = 36;
    final int tableHigth = documentos.length >= 3 ? 3 : documentos.length;

    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
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
              formFacturaBloc: formFacturaBloc,
              stateManager: stateManager,
              context: context,
            ),
            onRowChecked: (PlutoGridOnRowCheckedEvent event) => onRowChecked(
              event: event,
              documentos: documentos,
              formFacturaBloc: formFacturaBloc,
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
    required FormFacturaBloc formFacturaBloc,
    required PlutoGridStateManager stateManager,
    required BuildContext context,
  }) {
    final Documento documento = documentos[event.rowIdx];
    if (event.row.checked!) {
      stateManager.setRowChecked(event.row, false);
      formFacturaBloc.add(RemoveDocumentoFormFacturaEvent(documento));
    } else {
      if (documento.valorEgreso > documento.valorIngreso) {
        stateManager.setRowChecked(event.row, false);
        showErrorIngresoVSEgresoDialog(context, documento);
      } else if (documento.isAnulacion) {
        stateManager.setRowChecked(event.row, false);
        showErrorAnulacionDialog(context, documento);
      } else {
        stateManager.setRowChecked(event.row, true);
        formFacturaBloc.add(AddDocumentoFormFacturaEvent(documento));
      }
    }
  }

  void onRowChecked({
    required PlutoGridOnRowCheckedEvent event,
    required List<Documento> documentos,
    required FormFacturaBloc formFacturaBloc,
    required PlutoGridStateManager stateManager,
    required BuildContext context,
  }) {
    if (event.isAll) {
      for (final Documento documento in documentos) {
        if (event.isChecked!) {
          if (documento.valorEgreso > documento.valorIngreso) {
            showErrorIngresoVSEgresoDialog(context, documento);
          } else if (documento.isAnulacion) {
            showErrorAnulacionDialog(context, documento);
          } else {
            formFacturaBloc.add(AddDocumentoFormFacturaEvent(documento));
          }
        } else {
          formFacturaBloc.add(RemoveDocumentoFormFacturaEvent(documento));
        }
      }
    } else if (event.rowIdx != null && event.isChecked != null) {
      final Documento documento = documentos[event.rowIdx!];
      if (event.isChecked!) {
        if (documento.valorEgreso > documento.valorIngreso) {
          stateManager.setRowChecked(event.row!, false);
          showErrorIngresoVSEgresoDialog(context, documento);
        } else if (documento.isAnulacion) {
          stateManager.setRowChecked(event.row!, false);
          showErrorAnulacionDialog(context, documento);
        } else {
          formFacturaBloc.add(AddDocumentoFormFacturaEvent(documento));
        }
      } else {
        formFacturaBloc.add(RemoveDocumentoFormFacturaEvent(documento));
      }
    }
  }
}

void showErrorIngresoVSEgresoDialog(BuildContext context, Documento documento) {
  final Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      content: SizedBox(
        width: size.width * 0.3,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(Icons.info_outline_rounded, size: size.height * 0.1, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 16),
              Text(
                "El documento ${documento.documento}, presenta inconcistencias en los valores de egresos VS ingresos, No es posible facturar este documento",
                style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
              ),
              const SizedBox(height: 16),
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
