import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';

class HeaderFacturaPDF extends pw.StatelessWidget {
  HeaderFacturaPDF({
    required this.imageEmmpresa,
    required this.imageSuper,
    required this.imageQR,
  });
  final pw.ImageProvider imageEmmpresa;
  final pw.ImageProvider imageSuper;
  final pw.ImageProvider imageQR;
  @override
  pw.Widget build(pw.Context context) {
    final pw.TextStyle ligthTextStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 8);
    final pw.TextStyle fontBoldMinStyle = pw.TextStyle(font: fontPoppinsBold, fontSize: 14);
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: <pw.Widget>[
        pw.Container(
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Image(imageEmmpresa, height: 80),
              pw.SizedBox(width: 8),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Row(
                    children: <pw.Widget>[
                      pw.Text('Ferricar SAS', style: fontBoldMinStyle),
                      pw.Container(
                        margin: const pw.EdgeInsets.only(top: 5.6, left: 1),
                        height: 4,
                        width: 4,
                        child: pw.Circle(fillColor: PdfColors.red),
                      ),
                    ],
                  ),
                  pw.Text('NIT: 901051109-0', style: ligthTextStyle),
                ],
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 100),
        pw.Container(
          child: pw.Row(
            children: <pw.Widget>[
              pw.Container(
                height: 48,
                width: 48,
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Image(imageSuper),
              ),
              pw.SizedBox(width: 16),
              pw.Container(
                height: 72,
                width: 72,
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Image(imageQR),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
