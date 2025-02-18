import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';

class MunicipioRequestModel extends MunicipioRequest {
  MunicipioRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoDane,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.departamento,
  });

  factory MunicipioRequestModel.fromMap(Map<String, dynamic> map) {
    return MunicipioRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['isActivo'],
      codigoDane: map['codigoDane'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
      nombreUsuario: map['nombreUsuario'],
      departamento: map['departamento'],
    );
  }

  factory MunicipioRequestModel.fromRequest(MunicipioRequest request) {
    return MunicipioRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      codigoDane: request.codigoDane,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      nombreUsuario: request.nombreUsuario,
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
      'codigoDane': codigoDane,
      'nombreUsuario': nombreUsuario,
      'codigoDepartamento': departamento,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
