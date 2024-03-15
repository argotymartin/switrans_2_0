import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';

enum TipoVariacion { adicion, descuento }

class CardAdicionesAndDescuentos extends StatelessWidget {
  final List<Documento> documentos;
  final String title;
  final Color color;
  const CardAdicionesAndDescuentos({
    super.key,
    required this.documentos,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    TipoVariacion tipoVariacion = title == "ADICIONES" ? TipoVariacion.adicion : TipoVariacion.descuento;
    return Container(
      padding: const EdgeInsets.only(bottom: 16, top: 8, right: 8, left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: color,
                child: const Icon(Icons.currency_exchange, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: CustomFunctions.oscurecerColor(color, 0.5), fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Container(width: double.infinity, height: 1, color: color),
          const SizedBox(height: 8),
          SizedBox(
            child: _BuildTable(documentos: documentos, color: color, tipoVariacion: tipoVariacion),
          ),
        ],
      ),
    );
  }
}

class _BuildTable extends StatelessWidget {
  const _BuildTable({
    required this.documentos,
    required this.color,
    required this.tipoVariacion,
  });

  final List<Documento> documentos;
  final Color color;
  final TipoVariacion tipoVariacion;

  @override
  Widget build(BuildContext context) {
    List<TableRow> buildTableRows = documentos
        .map(
          (documento) => TableRow(
            children: [
              Center(
                child: Text(
                  documento.remesa.toString(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tipoVariacion == TipoVariacion.adicion
                    ? documento.adiciones.map((a) => const Text("2021-02-02")).toList()
                    : documento.descuentos.map((a) => const Text("2021-02-02")).toList(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tipoVariacion == TipoVariacion.adicion
                    ? documento.adiciones.map((a) => Text(a.tipo.toUpperCase())).toList()
                    : documento.descuentos.map((a) => Text(a.tipo.toUpperCase())).toList(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: tipoVariacion == TipoVariacion.adicion
                    ? documento.adiciones.map((a) => CurrencyLabel(text: a.valor.toInt().toString(), color: color)).toList()
                    : documento.descuentos.map((a) => CurrencyLabel(text: a.valor.toInt().toString(), color: color)).toList(),
              ),
            ],
          ),
        )
        .toList();

    double total = tipoVariacion == TipoVariacion.adicion
        ? documentos
            .map((documento) => documento.adiciones.fold(0, (total, adicion) => total + adicion.valor.toInt()))
            .fold(0, (total, subtotal) => total + subtotal)
        : documentos
            .map((documento) => documento.descuentos.fold(0, (total, descuento) => total + descuento.valor.toInt()))
            .fold(0, (total, subtotal) => total + subtotal);

    return Table(
      border: TableBorder.all(color: Colors.grey.shade200, width: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {2: FractionColumnWidth(0.5)},
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: [
            TableCell(
              child: Container(
                width: 4,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Remesa",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TableCell(
              child: Container(
                width: 4,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Fecha",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TableCell(
              child: Container(
                width: 4,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Tipo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TableCell(
              child: Container(
                width: 4,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Valor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        ...buildTableRows,
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            const TableCell(child: SizedBox()),
            const TableCell(child: SizedBox()),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                child: CurrencyLabel(
                  color: CustomFunctions.oscurecerColor(color, 0.5),
                  text: '${total.toInt()}',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
