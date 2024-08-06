import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';

class TipoImpuestoRequestModel extends TipoImpuestoRequest {
  TipoImpuestoRequestModel({
    super.codigo,
    super.usuario,
    super.nombre,
    super.isActivo,
  });

  factory TipoImpuestoRequestModel.fromRequestPB(TipoImpuestoRequest request) {
    return TipoImpuestoRequestModel(
      codigo: request.codigo,
      usuario: request.usuario,
      nombre: request.nombre,
      isActivo: request.isActivo,
    );
  }

  factory TipoImpuestoRequestModel.fromTable(Map<String, dynamic> map) => TipoImpuestoRequestModel(
        codigo: map['codigo'],
        usuario: map['usuario'] is String ? int.parse(map['usuario']) : map['usuario'],
        nombre: map['nombre'],
        isActivo: map['activo'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'usuario': usuario,
      'nombre': nombre,
      'codigo': codigo,
      'is_activo': isActivo,
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

    if (map["is_activo"] != null) {
      conditions.add('is_activo = ${map["is_activo"]}');
    }

    final String queryString = conditions.isNotEmpty ? conditions.join("&&") : conditions.join();
    final String data = queryString.isNotEmpty ? "($queryString)" : "";
    return data;
  }
}
