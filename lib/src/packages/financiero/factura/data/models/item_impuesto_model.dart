import 'package:switrans_2_0/src/packages/financiero/factura/data/models/impuesto_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_impuesto.dart';

class ItemImpuestoModel extends ItemImpuesto {
  ItemImpuestoModel({required super.impuestos, required super.total});

  factory ItemImpuestoModel.fromJson(Map<String, dynamic> json) => ItemImpuestoModel(
        total: json["totalImpuestos"],
        impuestos: List<Impuesto>.from(json["detalleImpuestos"].map((dynamic x) => ImpuestoModel.fromJson(x))),
      );
}
