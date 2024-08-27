import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';

class ItemImpuesto {
  final double total;
  final List<Impuesto> impuestos;

  ItemImpuesto({
    required this.total,
    required this.impuestos,
  });
}
