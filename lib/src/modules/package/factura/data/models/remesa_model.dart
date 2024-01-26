import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';

class RemesaModel extends Remesa {
  RemesaModel({
    required super.impreso,
    required super.numero,
    required super.centroCosto,
    required super.tipo,
    required super.obervaciones,
    required super.adiciones,
    required super.descuentos,
    required super.flete,
    required super.tarifaBase,
    required super.rcp,
  });

  factory RemesaModel.fromJson(Map<String, dynamic> json) => RemesaModel(
        impreso: json['impreso'],
        numero: json['numero'],
        centroCosto: json['centro_costo'],
        tipo: json['tipo'],
        obervaciones: json['obervaciones'],
        adiciones: json['adiciones'],
        descuentos: json['descuentos'],
        flete: json['flete'],
        tarifaBase: json['tarifaBase'],
        rcp: json['rcp'],
      );
}
