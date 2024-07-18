import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';

class InformacionFacturaPDF extends pw.StatelessWidget {
  InformacionFacturaPDF();

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      children: <pw.Widget>[
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            _InformacionFactura(),
            pw.SizedBox(width: 4),
            _Factura(),
          ],
        ),
        pw.SizedBox(height: 8),
        _MedioPago(),
      ],
    );
  }
}

class _InformacionFactura extends pw.StatelessWidget {
  _InformacionFactura();

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
                element: InfoElement(title: "CENTRO DE COSTO", contenet: "COTA - COOPIDROGAS FERRICAR"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "SEÑORES", contenet: "COOPERATIVA NACIONAL DE DROGUISTAS DETALLISTA"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DIRECCION", contenet: "AUTO. BTA-MED KM 4.7 ANTES DEL PTE SIBERIA"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "REMITENTE", contenet: "COOPIDROGAS COTA"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DESTINATARIO", contenet: "COOPIDROGAS SOGAMOSO"),
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
                element: InfoElement(title: "NIT", contenet: "860026123 - 0"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "TELEFONO", contenet: "3202356395"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DOMICILIO", contenet: "AUTOPISTA BOGOTA MEDELLIN KILOMETRO 4.7"),
              ),
              _BuildDataElement(
                element: InfoElement(title: "DIRECCION", contenet: "SOGAMOSO SOGAMOSO"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Factura extends pw.StatelessWidget {
  _Factura();

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
          pw.Text("E044 - 4884", style: fontBoldMinStyle),
          pw.SizedBox(height: 8),
          pw.Text("Fecha de Vencimiento: ", style: ligthTextStyle),
          pw.Text("09/06/2024: ", style: semiBoldTextStyle),
        ],
      ),
    );
  }
}

class _MedioPago extends pw.StatelessWidget {
  _MedioPago();

  @override
  pw.Widget build(pw.Context context) {
    final pw.TextStyle ligthTextStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 8);
    final pw.TextStyle semiBoldTextStyle = pw.TextStyle(font: fontSemiBold, fontSize: 8);
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Row(
        children: <pw.Widget>[
          pw.Text("DEBE A: ", style: ligthTextStyle),
          pw.Text("FERRICAR S.A.S", style: semiBoldTextStyle),
          pw.SizedBox(width: 16),
          pw.Text("FORMA DE PAGO: ", style: ligthTextStyle),
          pw.Text("Crédito", style: semiBoldTextStyle),
          pw.SizedBox(width: 16),
          pw.Text("MEDIO DE PAGO: ", style: ligthTextStyle),
          pw.Text("Consignacion bancaria", style: semiBoldTextStyle),
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
