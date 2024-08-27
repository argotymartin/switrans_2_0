import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';

class InformacionFacturaPDF extends pw.StatelessWidget {
  final DataPdf dataPdf;
  InformacionFacturaPDF(this.dataPdf);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      children: <pw.Widget>[
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            _InformacionFactura(dataPdf),
            pw.SizedBox(width: 4),
            _Factura(dataPdf),
          ],
        ),
        pw.SizedBox(height: 8),
        _MedioPago(dataPdf),
      ],
    );
  }
}

class _InformacionFactura extends pw.StatelessWidget {
  final DataPdf dataPdf;
  _InformacionFactura(this.dataPdf);

  @override
  pw.Widget build(pw.Context context) {
    final DateTime currenDate = DateTime.now();

    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.red200)),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisSize: pw.MainAxisSize.min,
            children: <pw.Widget>[
              _BuildDataElement(
                element: InfoElement(title: "CENTRO DE COSTO", contenet: dataPdf.centroCosto.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "SEÑORES", contenet: dataPdf.cliente.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DIRECCION", contenet: dataPdf.direccion.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "REMITENTE", contenet: dataPdf.remitente.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DESTINATARIO", contenet: dataPdf.destinatario.toUpperCase()),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              _BuildDataElement(
                element: InfoElement(title: "FECHA", contenet: currenDate.toString()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "NIT", contenet: dataPdf.nit.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "TELEFONO", contenet: dataPdf.telefono.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DOMICILIO", contenet: dataPdf.domicilio.toUpperCase()),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DIRECCION", contenet: dataPdf.direccion.toUpperCase()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Factura extends pw.StatelessWidget {
  final DataPdf dataPdf;
  _Factura(this.dataPdf);

  @override
  pw.Widget build(pw.Context context) {
    final pw.TextStyle ligthTextStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 8);
    final pw.TextStyle fontBoldMinStyle = pw.TextStyle(font: fontPoppinsBold, fontSize: 14);
    final pw.TextStyle semiBoldTextStyle = pw.TextStyle(font: fontSemiBold, fontSize: 8);
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      width: 120,
      child: pw.Column(
        children: <pw.Widget>[
          pw.Text("FACTURA ELECTRÓNICA DE VENTA No", style: ligthTextStyle, textAlign: pw.TextAlign.center),
          pw.Text(dataPdf.numeroFactura, style: fontBoldMinStyle),
          pw.SizedBox(height: 8),
          pw.Text("Fecha de Vencimiento: ", style: ligthTextStyle),
          pw.Text(dataPdf.fechaVencimiento, style: semiBoldTextStyle),
        ],
      ),
    );
  }
}

class _MedioPago extends pw.StatelessWidget {
  final DataPdf dataPdf;
  _MedioPago(this.dataPdf);

  @override
  pw.Widget build(pw.Context context) {
    final pw.TextStyle ligthTextStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 8);
    final pw.TextStyle semiBoldTextStyle = pw.TextStyle(font: fontSemiBold, fontSize: 8);
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Row(
        children: <pw.Widget>[
          pw.Text("DEBE A: ", style: ligthTextStyle),
          pw.Text(dataPdf.empresa, style: semiBoldTextStyle),
          pw.SizedBox(width: 16),
          pw.Text("FORMA DE PAGO: ", style: ligthTextStyle),
          pw.Text(dataPdf.formaPago, style: semiBoldTextStyle),
          pw.SizedBox(width: 16),
          pw.Text("MEDIO DE PAGO: ", style: ligthTextStyle),
          pw.Text(dataPdf.medioPago, style: semiBoldTextStyle),
        ],
      ),
    );
  }
}

class _BuildDataElement extends pw.StatelessWidget {
  _BuildDataElement({required this.element});
  final InfoElement element;

  @override
  pw.Widget build(pw.Context context) {
    final pw.TextStyle ligthTextStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 8);
    final pw.TextStyle semiBoldTextStyle = pw.TextStyle(font: fontSemiBold, fontSize: 8);
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Container(width: 64, child: pw.Text("${element.title}: ", style: ligthTextStyle)),
          pw.Container(width: 140, child: pw.Text(element.contenet, style: semiBoldTextStyle)),
        ],
      ),
    );
  }
}

class InfoElement {
  final String title;
  final String contenet;
  InfoElement({
    required this.title,
    required this.contenet,
  });
}
