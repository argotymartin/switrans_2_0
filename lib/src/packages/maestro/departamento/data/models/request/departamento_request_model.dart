import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';

class DepartamentoRequestModel extends DepartamentoRequest {
  DepartamentoRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoDane,
    required super.codigoUsuario,
    required super.pais,
  });

  factory DepartamentoRequestModel.fromMap(Map<String, dynamic> map) {
    return DepartamentoRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['isActivo'],
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
      isActivo: request.isActivo,
      codigoDane: request.codigoDane,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      pais: request.pais,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': isActivo,
      'codigoDane': codigoDane,
      'fechaCreacion': fechaCreacion,
      'codigoUsuario': codigoUsuario,
      'codigoPais': pais,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
