import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';

class DepartamentoRequestModel extends DepartamentoRequest {
  DepartamentoRequestModel({
    required super.codigo,
    required super.nombre,
    required super.estado,
    required super.fechaCreacion,
    required super.codigoDane,
    required super.codigoUsuario,
    required super.pais,
  });

  factory DepartamentoRequestModel.fromTable(Map<String, dynamic> map) {
    return DepartamentoRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      estado: map['activo'],
      codigoDane: map['codigoDane'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
      pais: map['pais'],
    );
  }

  factory DepartamentoRequestModel.fromRequest(DepartamentoRequest request) {
    return DepartamentoRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      estado: request.estado,
      codigoDane: request.codigoDane,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      pais: request.pais,
    );
  }

  Map<String, dynamic> toJson() {
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
      'codigoPais': pais,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  Map<String, dynamic> toJsonGet() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'codigoPais': pais,
      'estado': estado,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
