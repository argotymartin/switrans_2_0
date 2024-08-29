import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';
import 'package:switrans_2_0/src/util/resources/formatters/formatear_miles.dart';

class FooterFacturaPDF extends pw.StatelessWidget {
  final DataPdf data;
  FooterFacturaPDF(this.data);
  @override
  pw.Widget build(pw.Context context) {
    final pw.TextStyle ligthMinStyle6 = pw.TextStyle(font: fontPoppinsLigth, fontSize: 6);
    final pw.TextStyle ligthMinStyle5 = pw.TextStyle(font: fontPoppinsLigth, fontSize: 5);
    final pw.TextStyle fontBoldMinStyle = pw.TextStyle(font: fontSemiBold, fontSize: 8);
    double total = 0;
    double subTotal = 0;
    final Map<String, double> mapImpuestos = <String, double>{};
    final List<pw.Row> childrenImpuestos = <pw.Row>[];
    for (final Documento doc in data.documentos) {
      for (final ItemDocumento item in doc.itemDocumentos) {
        subTotal += item.subtotal;
        total += item.total;
      }

      for (final Impuesto imp in doc.impuestos) {
        mapImpuestos.update(
          imp.nombre,
          (double existingValue) => existingValue + imp.valor,
          ifAbsent: () => imp.valor,
        );
      }
    }

    mapImpuestos.forEach((String key, double value) {
      childrenImpuestos.add(
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.SizedBox(width: 64, child: pw.Text(key, style: pw.TextStyle(font: fontSemiBold, fontSize: 10))),
            pw.Container(
              width: 92,
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                "COP \$${formatearMiles(value.toString())}",
                style: pw.TextStyle(font: fontPoppinsLigth, fontSize: 9, color: key == "IVA" ? PdfColors.green800 : PdfColors.red800),
              ),
            ),
          ],
        ),
      );
    });
    return pw.Column(
      children: <pw.Widget>[
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: <pw.Widget>[
            pw.Column(
              children: <pw.Widget>[
                _buildItemsInformacion(
                  title: "NOTA",
                  content:
                      "Señor contribuyente, si usted es retenedor de ICA en el municipio de COTA, practicar tarifa 0.5%, de lo contrario abstengase de practicar dicha retencion.",
                  titleStyle: fontBoldMinStyle,
                  contentStyle: ligthMinStyle6,
                ),
                pw.SizedBox(height: 2),
                _buildItemsInformacion(
                  title: "SON",
                  content: "CIENTO TREINTA MILLONES DOSCIENTOS VEINTIÚN MIL NOVECIENTOS SESENTA Y OCHO PESOS CERO CENTAVOS",
                  titleStyle: fontBoldMinStyle,
                  contentStyle: ligthMinStyle6,
                ),
                pw.SizedBox(height: 2),
                _buildItemsInformacion(
                  title: "NOTA",
                  content: "xxxxxxxxx",
                  titleStyle: fontBoldMinStyle,
                  contentStyle: ligthMinStyle6,
                ),
                pw.SizedBox(height: 2),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Row(
                  children: <pw.Widget>[
                    pw.SizedBox(width: 64, child: pw.Text("SUBTOTAL", style: pw.TextStyle(font: fontSemiBold, fontSize: 12))),
                    pw.Container(
                      width: 92,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        "COP \$${formatearMiles(subTotal.toString())}",
                        style: pw.TextStyle(font: fontPoppinsLigth, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                ...childrenImpuestos,
                pw.Row(
                  children: <pw.Widget>[
                    pw.SizedBox(width: 64, child: pw.Text("TOTAL", style: pw.TextStyle(font: fontSemiBold, fontSize: 14))),
                    pw.Container(
                      width: 92,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        "COP \$${formatearMiles(total.toString())}",
                        style: pw.TextStyle(font: fontSemiBold, fontSize: 11, color: PdfColors.green800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        pw.Row(
          children: <pw.Widget>[
            pw.Container(
              width: 344,
              child: pw.Row(
                children: <pw.Widget>[
                  pw.Container(
                    width: 162,
                    child: pw.Column(
                      children: <pw.Widget>[
                        pw.Container(
                          height: 50,
                          width: 162,
                          padding: const pw.EdgeInsets.all(2),
                          decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                          child: pw.Text(
                            "ESTA FACTURA SE ASIMILA EN SUS EFECTOS A UNA LETRA DE CAMBIO. FAVOR CANCELAR LA PRESENTE FACTURA CON CHEQUE CRUZADO AL PRIMER BENEFICIARIO Y/O TRANSFERENCIA.",
                            style: ligthMinStyle5,
                          ),
                        ),
                        pw.Row(
                          children: <pw.Widget>[
                            pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                              width: 54,
                              height: 50,
                              child: pw.Column(
                                children: <pw.Widget>[
                                  pw.Text("ELABORADO", style: ligthMinStyle5),
                                  pw.SizedBox(height: 4),
                                  pw.Text("DUBAN CAMILO FAJARDO MONTENEGRO", style: ligthMinStyle6),
                                ],
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                              width: 54,
                              height: 50,
                              child: pw.Column(
                                children: <pw.Widget>[
                                  pw.Text("REVISADO", style: ligthMinStyle5),
                                ],
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                              width: 54,
                              height: 50,
                              child: pw.Column(
                                children: <pw.Widget>[
                                  pw.Text("ENTREGADO", style: ligthMinStyle5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    height: 100,
                    width: 182,
                    padding: const pw.EdgeInsets.all(2),
                    decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                    child: pw.Text(
                      "Con la aceptacionexpresa del contenido de factura, el remitente y destinatario, dan  plena contancia del recibo de la mercancia, asi como la ejecucuion del servicio de transporte a entera satisfaccion. Se hace constar que la firma de una persona distinta al destinatario, implica que dicha persona se entiende autorizada expresamente por el destinatario para firmar, confesar la deuda y obligar al comprador y que actua en su representacion. El remitente y destinatario aceptan esta factura con la imposicion del sello en el evento de que no reclamen sobre el contenido de la presente factura dentro de los ENTREGADO tres (3) dias siguientes a la fecha de su recibo. Se entendera irrevocablemente aceptada. Si esta factura de venta no es cancelada dentro del plazo convenido causara intereses por mora a la tasa que certifique la superintendencia financiera, sin perjuicio de las acciones legales a que haya lugar",
                      style: ligthMinStyle5,
                    ),
                  ),
                ],
              ),
            ),
            pw.Column(
              children: <pw.Widget>[
                pw.Container(
                  height: 50,
                  width: 184,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                  child: pw.Column(
                    children: <pw.Widget>[
                      pw.Text(
                        "ACEPTADA Y RECIBIDA A ENTERA SATISFACCION",
                        style: ligthMinStyle6,
                      ),
                      pw.SizedBox(height: 24),
                      pw.Text(
                        "NOMBRE",
                        style: ligthMinStyle6,
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  height: 50,
                  width: 184,
                  padding: const pw.EdgeInsets.all(2),
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
                  child: pw.Column(
                    children: <pw.Widget>[
                      pw.SizedBox(height: 36),
                      pw.Text(
                        "SELLO Y FIRMA AUTORIZADA C.C./ NIT",
                        style: ligthMinStyle6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Text(
          "Sede Principal Calle 17A No 69B 05 Local 2 Zona Industrial Montevideo",
          style: pw.TextStyle(font: fontPoppinsLigth, fontSize: 7),
        ),
        pw.SizedBox(height: 16),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              "NO SOMOS GRANDES CONTRIBUYENTES NO SOMOS RETENEDORES DE IVA ACTIVIDAD ECONOMICA 4923",
              style: pw.TextStyle(font: fontPoppinsLigth, fontSize: 5),
            ),
            pw.Text(
              "EL SERVICIO DE TRANSPORTE DE CARGA ESTA EXCLUIDO DE IVA IVA REGIMEN COMUN",
              style: pw.TextStyle(font: fontPoppinsLigth, fontSize: 5),
            ),
          ],
        ),
      ],
    );
  }
}

pw.Widget _buildItemsInformacion({
  required pw.TextStyle titleStyle,
  required pw.TextStyle contentStyle,
  required String title,
  required String content,
}) {
  return pw.Row(
    children: <pw.Widget>[
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200), color: PdfColors.grey200),
        width: 24,
        height: 24,
        child: pw.Center(child: pw.Text(title, style: titleStyle)),
      ),
      pw.Container(
        height: 24,
        width: 320,
        padding: const pw.EdgeInsets.all(4),
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey200)),
        child: pw.Center(
          child: pw.Text(
            content,
            style: contentStyle,
          ),
        ),
      ),
    ],
  );
}
