import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class PdfView extends StatelessWidget {
  final List<Documento> documentos;
  const PdfView({required this.documentos, super.key});

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      previewPageMargin: const EdgeInsets.all(60),
      allowSharing: false,
      canChangePageFormat: false,
      canChangeOrientation: false,
      canDebug: false,
      loadingWidget: const LoadingView(),
      build: (PdfPageFormat format) async {
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
          documentos: documentos,
          empresa: "xxxxx",
          fechaVencimiento: "xxxxx",
          formaPago: "xxxxx",
          medioPago: "xxxxx",
          numeroFactura: "xxx - xxx",
        );
        final Future<Uint8List> pdf = generateDocument(format, dataPDF);
        return pdf;
      },
    );
  }
}
