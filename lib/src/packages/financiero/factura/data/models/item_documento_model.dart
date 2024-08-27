import 'package:switrans_2_0/src/packages/financiero/factura/data/models/item_impuesto_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class ItemDocumentoModel extends ItemDocumento {
  ItemDocumentoModel({
    required super.servicioCodigo,
    required super.servicioNombre,
    required super.subtotal,
    required super.total,
    required super.impuestos,
  });

  factory ItemDocumentoModel.fromJson(Map<String, dynamic> json) {
    return ItemDocumentoModel(
      servicioNombre: json["servicioNombre"],
      servicioCodigo: json["servicioCodigo"],
      total: json["total"],
      impuestos: ItemImpuestoModel.fromJson(json['impuestos']),
      subtotal: json["subtotal"],
    );
  }
}
