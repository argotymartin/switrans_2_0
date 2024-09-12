import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/blocs/factura/factura_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        final DataPdf dataPDF = DataPdf(
          centroCosto: "xxxxx",
          cliente: "xxxxx",
          nitCliente: "xxxxx",
          destinatario: "xxxxx",
          direccion: "xxxxx",
          direccionCliente: "xxxxx",
          domicilio: "xxxxx",
          fecha: DateTime.now().toString(),
          nit: "xxxxx",
          remitente: "xxxxx",
          telefono: "xxxxx",
          documentos: state.documentosSelected,
          empresa: "xxxxx",
          fechaVencimiento: "xxxxx",
          formaPago: "xxxxx",
          medioPago: "xxxxx",
          numeroFactura: "xxx - xxx",
        );
        return PdfPreview(
          previewPageMargin: const EdgeInsets.all(60),
          allowSharing: false,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          loadingWidget: const LoadingView(),
          build: (PdfPageFormat format) async {
            final Future<Uint8List> pdf = generateDocument(format, dataPDF);
            return pdf;
          },
        );
      },
    );
  }
}
