import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/cache/font_cache.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/cache/image_cache.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/footer_factura_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/header_factura_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/informacion_factura_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/widgets/table_factura_pdf.dart';

late pw.Font fontPoppinsBold;
late pw.Font fontPoppinsRegular;
late pw.Font fontPoppinsLigth;
late pw.Font fontSemiBold;
final pw.SizedBox spacerBox = pw.SizedBox(height: 20);
List<Documento> itemDocuemto = <Documento>[];

Future<Uint8List> generateDocument(PdfPageFormat format, DataPdf data) async {
  final pw.Document doc = pw.Document(
    title: 'Factura',
    author: "Erney",
  );

  final pw.MemoryImage imageEmpresa = await ImageCacheCustom.getImage('assets/empresas/ferricar.png');
  final pw.MemoryImage imageSuper = await ImageCacheCustom.getImage('assets/supertransporte.png');
  final pw.MemoryImage imageQR = await ImageCacheCustom.getImage('assets/qr.png');

  fontPoppinsBold = await FontCache.getFont('poppinsBold');
  fontPoppinsRegular = await FontCache.getFont('poppinsRegular');
  fontPoppinsLigth = await FontCache.getFont('poppinsLight');
  fontSemiBold = await FontCache.getFont('poppinsSemiBold');

  doc.addPage(
    pw.MultiPage(
      margin: const pw.EdgeInsets.all(36),
      header: (pw.Context context) {
        return HeaderFacturaPDF(imageEmmpresa: imageEmpresa, imageSuper: imageSuper, imageQR: imageQR, data: data);
      },
      footer: (pw.Context context) {
        return buildFooter(context);
      },
      build: (pw.Context context) => <pw.Widget>[
        InformacionFacturaPDF(data),
        spacerBox,
        TableFacturaPDF(data),
        spacerBox,
        FooterFacturaPDF(data),
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
  final String centroCosto;
  final String cliente;
  final String nitCliente;
  final String direccionCliente;
  final String remitente;
  final String destinatario;
  final String fecha;
  final String telefono;
  final String domicilio;
  final String direccion;
  final String empresa;
  final String nit;
  final String formaPago;
  final String medioPago;
  final String numeroFactura;
  final String fechaVencimiento;

  final List<Documento> documentos;
  DataPdf({
    required this.centroCosto,
    required this.cliente,
    required this.nitCliente,
    required this.direccionCliente,
    required this.remitente,
    required this.destinatario,
    required this.fecha,
    required this.nit,
    required this.telefono,
    required this.domicilio,
    required this.direccion,
    required this.empresa,
    required this.formaPago,
    required this.medioPago,
    required this.numeroFactura,
    required this.fechaVencimiento,
    this.documentos = const <Documento>[],
  });
}
