import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/request/departamento_request.dart';

class DepartamentoRequestModel extends DepartamentoRequest {
  DepartamentoRequestModel({
    required super.codigo,
    required super.codigoUsuario,
    required super.codigoDane,
    required super.fechaCreacion,
    required super.nombre,
    required super.pais,
    required super.estado,
  });

  factory DepartamentoRequestModel.fromRequestPB(DepartamentoRequest request) {
    return DepartamentoRequestModel(
      codigo: request.codigo,
      codigoUsuario: request.codigoUsuario,
      codigoDane: request.codigoDane,
      fechaCreacion: request.fechaCreacion,
      nombre: request.nombre,
      pais: request.pais,
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

  factory DepartamentoRequestModel.fromTable(Map<String, dynamic> map) {
    return DepartamentoRequestModel(
      codigo: map['codigo'],
      codigoUsuario: map['codigoUsuario'],
      codigoDane: map['codigoDane'],
      fechaCreacion: map['fechaCreacion'],
      nombre: map['nombre'],
      pais: map['pais'],
      estado: map['activo'],
    );
  }

  factory DepartamentoRequestModel.fromRequestAPI(DepartamentoRequest request) {
    return DepartamentoRequestModel(
      codigo: request.codigo,
      codigoUsuario: request.codigoUsuario,
      codigoDane: request.codigoDane,
      fechaCreacion: request.fechaCreacion,
      nombre: request.nombre,
      pais: request.pais,
      estado: request.estado,
    );
  }

  Map<String, dynamic> toJsonAPI() {
    return <String, dynamic>{
      'codigo': codigo,
      'codigoUsuario': codigoUsuario,
      'codigoDane': codigoDane,
      'fechaCreacion': fechaCreacion,
      'nombre': nombre,
      'codigoPais': pais,
      'estado': estado,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  Map<String, dynamic> toJsonConsultarAPI() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'codigoPais': pais,
      'estado': estado,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  Map<String, dynamic> toJsonCrearAPI() {
    return <String, dynamic>{
      'codigoUsuario': codigoUsuario,
      'codigoDane': codigoDane,
      'nombre': nombre,
      'codigoPais': pais,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  Map<String, dynamic> toJsonUpdateAPI() {
    return <String, dynamic>{
      'estado': estado,
      'nombre': nombre,
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
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  static String toBaseFilter(Map<String, dynamic> map) {
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
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }
}
