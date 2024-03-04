import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';

class TipoImpuestoModel extends TipoImpuesto {
  TipoImpuestoModel({required super.codigo, required super.nombre, required super.usuario});

  factory TipoImpuestoModel.fromJson(Map<String, dynamic> json) => TipoImpuestoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        usuario: json['usuario'],
      );
}
