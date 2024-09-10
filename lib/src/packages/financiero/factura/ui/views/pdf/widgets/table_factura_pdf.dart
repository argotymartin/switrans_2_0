import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/pdf/generate_pdf.dart';
import 'package:switrans_2_0/src/util/resources/formatters/formatear_miles.dart';

class TableFacturaPDF extends pw.StatelessWidget {
  final DataPdf data;
  TableFacturaPDF(this.data);

  @override
  pw.Widget build(pw.Context context) {
    const List<String> tableHeaders = <String>[
      "FECHA ",
      "REMESA",
      "DESCRIPCION",
      "SUBTOTAL",
      "IVA",
      "RETEIVA",
      "RETEFUENTE",
      "ICA",
      "TOTAL",
    ];

    final pw.TextStyle titleColumTextStyle = pw.TextStyle(font: fontPoppinsBold, fontSize: 6);
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
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerRight,
        7: pw.Alignment.centerRight,
        8: pw.Alignment.centerRight,
      },
      columnWidths: <int, pw.TableColumnWidth>{
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(4),
        2: const pw.FlexColumnWidth(4),
        3: const pw.FlexColumnWidth(2),
        4: const pw.FlexColumnWidth(2),
        5: const pw.FlexColumnWidth(2),
        6: const pw.FlexColumnWidth(2),
        7: const pw.FlexColumnWidth(2),
        8: const pw.FlexColumnWidth(2),
      },
      headerStyle: titleColumTextStyle,
      cellStyle: ligthMinStyle,
      headers: List<String>.generate(
        tableHeaders.length,
        (int col) => tableHeaders[col],
      ),
      data: data.documentos
          .map(
            (Documento e) => List<List<String>>.generate(e.itemDocumentos.length, (int index) {
              final ItemDocumento itemDocumento = e.itemDocumentos[index];
              double iva = 0.0;
              double reteIva = 0.0;
              double reteFuente = 0.0;
              double reteIca = 0.0;
              for (final Impuesto impuesto in itemDocumento.impuestos.impuestos) {
                if (impuesto.codigo == 6) {
                  iva = impuesto.valor;
                }
                if (impuesto.codigo == 1) {
                  reteIva = impuesto.valor;
                }
                if (impuesto.codigo == 4) {
                  reteFuente = impuesto.valor;
                }
                if (impuesto.codigo == 5) {
                  reteIca = impuesto.valor;
                }
              }
              return <String>[
                'xxxxx',
                "(${e.impreso.toUpperCase()}) \n${e.origen.toUpperCase()} - ${e.destino.toUpperCase()} ",
                e.itemDocumentos[index].servicioNombre,
                "\$${formatearMiles(itemDocumento.subtotal.toString())}",
                "\$${formatearMiles(iva.toString())}",
                "\$${formatearMiles(reteIva.toString())}",
                "\$${formatearMiles(reteFuente.toString())}",
                "\$${formatearMiles(reteIca.toString())}",
                "\$${formatearMiles(itemDocumento.total.toString())}",
              ];
            }),
          )
          .expand((List<List<String>> element) => element) // Aplana la lista de listas en una sola lista de filas
          .toList(),
    );
  }
}
