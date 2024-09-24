import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';

class PaisRequestModel extends PaisRequest {
  PaisRequestModel({
    required super.codigo,
    required super.codigoUsuario,
    required super.fechaCreacion,
    required super.nombre,
    required super.estado,
  });

  factory PaisRequestModel.fromRequestPB(PaisRequest request) {
    return PaisRequestModel(
      codigo: request.codigo,
      codigoUsuario: request.codigoUsuario,
      fechaCreacion: request.fechaCreacion,
      nombre: request.nombre,
      estado: request.estado,
    );
  }

  Map<String, dynamic> toJsonPB() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'activo': estado,
    };
  }

  factory PaisRequestModel.fromTable(Map<String, dynamic> map) {
    return PaisRequestModel(
      codigo: map['codigo'],
      codigoUsuario: map['codigoUsuario'],
      fechaCreacion: map['fechaCreacion'],
      nombre: map['nombre'],
      estado: map['activo'],
    );
  }

  factory PaisRequestModel.fromRequestAPI(PaisRequest request) {
    return PaisRequestModel(
      codigo: request.codigo,
      codigoUsuario: request.codigoUsuario,
      fechaCreacion: request.fechaCreacion,
      nombre: request.nombre,
      estado: request.estado,
    );
  }

  Map<String, dynamic> toJsonAPI() {
    return <String, dynamic>{
      'codigo': codigo,
      'codigoUsuario': codigoUsuario,
      'fechaCreacion': fechaCreacion,
      'nombre': nombre,
      'estado': estado,
    }..removeWhere((String key, dynamic value) => value == null);
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
