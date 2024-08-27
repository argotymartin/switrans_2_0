import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_impuesto.dart';

class ItemDocumento {
  final int servicioCodigo;
  final String servicioNombre;
  final double subtotal;
  final double total;
  final ItemImpuesto impuestos;

  ItemDocumento({
    required this.servicioCodigo,
    required this.servicioNombre,
    required this.subtotal,
    required this.total,
    required this.impuestos,
  });
}
