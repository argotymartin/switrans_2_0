import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/items_factura_test.dart';

class TableFacturaPDF extends pw.StatelessWidget {
  TableFacturaPDF();

  @override
  pw.Widget build(pw.Context context) {
    const List<String> tableHeaders = <String>[
      "FECHA ",
      "REMESA",
      "ORIGEN",
      "DESTINO",
      "IDENTIFICACION Y DESCRIPCION DE LOS SERVICIOS",
      "VALOR",
    ];
    final pw.TextStyle titleColumTextStyle = pw.TextStyle(font: fontPoppinsBold, fontSize: 8);
    final pw.TextStyle ligthMinStyle = pw.TextStyle(font: fontPoppinsLigth, fontSize: 6);
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.2),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)), color: PdfColors.grey200),
      headerHeight: 25,
      cellHeight: 20,
      cellAlignments: <int, pw.AlignmentGeometry>{
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerLeft,
        5: pw.Alignment.centerRight,
      },
      columnWidths: <int, pw.TableColumnWidth>{
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
        4: const pw.FlexColumnWidth(4),
        5: const pw.FlexColumnWidth(2),
      },
      headerStyle: titleColumTextStyle,
      cellStyle: ligthMinStyle,
      headers: List<String>.generate(
        tableHeaders.length,
        (int col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        itemsFactura.length,
        (int index) => <String>[
          itemsFactura[index]['fecha'].toString(),
          itemsFactura[index]['documento'].toString(),
          itemsFactura[index]['origen'].toString(),
          itemsFactura[index]['destino'].toString(),
          itemsFactura[index]['obs'].toString(),
          itemsFactura[index]['valor'].toString(),
        ],
      ),
    );
  }
}
