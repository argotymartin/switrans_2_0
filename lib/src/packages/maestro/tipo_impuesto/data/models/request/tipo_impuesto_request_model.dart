import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';

class TipoImpuestoRequestModel extends TipoImpuestoRequest {
  TipoImpuestoRequestModel({
    super.codigo,
    super.usuario,
    super.nombre,
    super.fechaInicio,
    super.fechaFin,
  });

  factory TipoImpuestoRequestModel.fromRequestPB(TipoImpuestoRequest request) {
    return TipoImpuestoRequestModel(
      codigo: request.codigo,
      usuario: request.usuario,
      nombre: request.nombre,
      fechaInicio: request.fechaInicio,
      fechaFin: request.fechaFin,
    );
  }

  factory TipoImpuestoRequestModel.fromTable(Map<String, dynamic> map) => TipoImpuestoRequestModel(
        codigo: map['codigo'],
        usuario: int.parse(map['usuario']),
        nombre: map['nombre'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'usuario': usuario,
      'nombre': nombre,
      'codigo': codigo,
    };

    return data;
  }

  static String toPocketBaseFilter(Map<String, dynamic> map) {
    final List<String> conditions = <String>[];

    if (map["nombre"] != null) {
      conditions.add('nombre ~ "${map["nombre"]}"');
    }

    if (map["codigo"] != null) {
      conditions.add('codigo = ${map["codigo"]}');
    }

    final String queryString = conditions.isNotEmpty ? conditions.join("&&") : conditions.join();
    final String data = queryString.isNotEmpty ? "($queryString)" : "";
    return data;
  }
}
