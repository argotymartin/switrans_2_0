import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/footer_factura_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/header_factura_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/informacion_factura_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/table_factura_pdf.dart';

late pw.Font fontPoppinsBold;
late pw.Font fontPoppinsRegular;
late pw.Font fontPoppinsLigth;
late pw.Font fontSemiBold;
final pw.SizedBox spacerBox = pw.SizedBox(height: 20);
List<ItemDocumento> itemDocuemto = <ItemDocumento>[];

Future<Uint8List> generatePreoperacional(PdfPageFormat format, DataPdf data) async {
  itemDocuemto = data.itemDocumentos;
  final pw.Document doc = pw.Document(
    title: 'Factura',
    author: "Erney",
  );

  final ByteData img1 = await rootBundle.load('assets/empresas/ferricar.png');
  final pw.MemoryImage imageEmpresa = pw.MemoryImage(img1.buffer.asUint8List());

  final ByteData img2 = await rootBundle.load('assets/supertransporte.png');
  final pw.MemoryImage imageSuper = pw.MemoryImage(img2.buffer.asUint8List());

  final ByteData img3 = await rootBundle.load('assets/qr.png');
  final pw.MemoryImage imageQR = pw.MemoryImage(img3.buffer.asUint8List());

  fontPoppinsBold = await PdfGoogleFonts.poppinsBold();
  fontPoppinsRegular = await PdfGoogleFonts.poppinsRegular();
  fontPoppinsLigth = await PdfGoogleFonts.poppinsLight();
  fontSemiBold = await PdfGoogleFonts.poppinsSemiBold();

  doc.addPage(
    pw.MultiPage(
      margin: const pw.EdgeInsets.all(36),
      header: (pw.Context context) {
        return HeaderFacturaPDF(imageEmmpresa: imageEmpresa, imageSuper: imageSuper, imageQR: imageQR);
      },
      footer: (pw.Context context) {
        return buildFooter(context);
      },
      build: (pw.Context context) => <pw.Widget>[
        InformacionFacturaPDF(),
        spacerBox,
        TableFacturaPDF(),
        spacerBox,
        FooterFacturaPDF(),
      ],
    ),
  );
  return doc.save();
}

pw.Row buildFooter(pw.Context context) {
  final pw.TextStyle ligthMinStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 7);

  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.end,
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: <pw.Widget>[
      pw.Text("Pagina ${context.pageNumber}/${context.pagesCount}", style: ligthMinStyle),
    ],
  );
}

class DataPdf {
  final String usuario;
  final String vehiculo;
  List<ItemDocumento> itemDocumentos;
  DataPdf({
    required this.usuario,
    required this.vehiculo,
    required this.itemDocumentos,
  });
}
