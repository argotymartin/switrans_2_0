import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/entities/tipo_impuesto.dart';

class TipoImpuestoModel extends TipoImpuesto {
  TipoImpuestoModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
  });

  factory TipoImpuestoModel.fromJson(Map<String, dynamic> json) => TipoImpuestoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        isActivo: json['estado'],
        fechaCreacion: json['fechaCreacion'].toString(),
        codigoUsuario: json['codigoUsuario'],
        nombreUsuario: json['nombreUsuario'],
      );
}
