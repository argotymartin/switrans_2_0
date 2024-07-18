import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        final DataPdf dataPDF = DataPdf(
          usuario: "Erney VArgas",
          vehiculo: "JYS 24D",
          itemDocumentos: state.itemDocumentos,
        );
        return PdfPreview(
          previewPageMargin: const EdgeInsets.all(60),
          canChangeOrientation: false,
          allowSharing: false,
          enableScrollToPage: true,
          loadingWidget: const LoadingView(),
          build: (PdfPageFormat format) async {
            final Future<Uint8List> pdf = generatePreoperacional(format, dataPDF);
            return pdf;
          },
        );
      },
    );
  }
}
