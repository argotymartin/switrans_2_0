import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';

class MunicipioRequestModel extends MunicipioRequest {
  MunicipioRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.usuarioNombre,
    required super.departamento,
  });

  factory MunicipioRequestModel.fromTable(Map<String, dynamic> map) {
    return MunicipioRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['activo'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
      usuarioNombre: map['usuarioNombre'],
      departamento: map['departamento'],
    );
  }

  factory MunicipioRequestModel.fromRequest(MunicipioRequest request) {
    return MunicipioRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      usuarioNombre: request.usuarioNombre,
      departamento: request.departamento,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': isActivo,
      'fechaCreacion': fechaCreacion,
      'codigoUsuario': codigoUsuario,
      'usuarioNombre': usuarioNombre,
      'codigoDepartamento': departamento,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  Map<String, dynamic> toJsonGet() {
    return <String, dynamic>{
      'codigo': codigo,
      'estado': isActivo,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
