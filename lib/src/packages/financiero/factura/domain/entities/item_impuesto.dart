import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';

class ItemImpuesto {
  final double total;
  final List<Impuesto> impuestos;

  ItemImpuesto({
    required this.total,
    required this.impuestos,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "totalImpuestos": total,
        "detalleImpuestos": List<dynamic>.from(impuestos.map((Impuesto x) => x.toJson())),
      };
}
