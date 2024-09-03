import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';

class PaisRequestModel extends PaisRequest {
  PaisRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
  });

  factory PaisRequestModel.fromRequestPB(PaisRequest request) {
    return PaisRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
    );
  }

  factory PaisRequestModel.fromTable(Map<String, dynamic> map) => PaisRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        isActivo: map['activo'],
      );

  Map<String, dynamic> toJsonPB() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'activo': isActivo,
    };
  }

  static String toPocketBaseFilter(Map<String, dynamic> map) {
    final List<String> conditions = <String>[];
    if (map["nombre"] != null) {
      conditions.add('nombre ~ "${map["nombre"]}"');
    }
    if (map["codigo"] != null) {
      conditions.add('codigo = ${map["codigo"]}');
    }
    if (map["activo"] != null) {
      conditions.add('activo = ${map["activo"]}');
    }
    if (map["modulo"] != null) {
      conditions.add('modulo = "${map["modulo"]}"');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }
}
