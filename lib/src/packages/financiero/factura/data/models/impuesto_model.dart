import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';

class ImpuestoModel extends Impuesto {
  ImpuestoModel({required super.codigo, required super.nombre, required super.valor});

  factory ImpuestoModel.fromJson(Map<String, dynamic> json) => ImpuestoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        valor: json['valor'],
      );
}
