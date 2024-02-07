import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';
import 'package:switrans_2_0/src/util/resources/custom_functions.dart';

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
    List<TableRow> buildTableRows = documentos
        .map((e) => TableRow(children: [
              Center(
                child: Text(
                  e.remesa.toString(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: title == "ADICIONES"
                    ? e.adiciones.map((a) => Text(a.tipo.toUpperCase())).toList()
                    : e.descuentos.map((a) => Text(a.tipo.toUpperCase())).toList(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: title == "ADICIONES"
                    ? e.adiciones.map((a) => CurrencyLabel(text: a.valor.toString(), color: color)).toList()
                    : e.descuentos.map((a) => CurrencyLabel(text: a.valor.toString(), color: color)).toList(),
              ),
            ]))
        .toList();

    int total = title == "ADICIONES"
        ? documentos
            .map((documento) => documento.adiciones.fold(0, (total, adicion) => total + adicion.valor))
            .fold(0, (total, subtotal) => total + subtotal)
        : documentos
            .map((documento) => documento.descuentos.fold(0, (total, descuento) => total + descuento.valor))
            .fold(0, (total, subtotal) => total + subtotal);

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color,
                child: const Icon(Icons.currency_exchange, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: CustomFunctions.oscurecerColor(color, 0.5), fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Container(width: 400, height: 1, color: color),
          const SizedBox(height: 8),
          SizedBox(
            width: 400,
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade200, width: 1),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {1: FractionColumnWidth(0.5)},
              children: [
                TableRow(decoration: BoxDecoration(color: Colors.grey.shade100), children: [
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
                ]),
                ...buildTableRows,
                TableRow(children: [
                  const TableCell(child: SizedBox()),
                  const TableCell(child: SizedBox()),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: CurrencyLabel(color: CustomFunctions.oscurecerColor(color, 0.5), text: total.toString()),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
