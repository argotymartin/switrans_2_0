import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';

class MunicipioRequestModel extends MunicipioRequest {
  MunicipioRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.latitud,
    required super.longitud,
    required super.codigoDane,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.codigoDepartamento,
    required super.codigoPais,

  });

  factory MunicipioRequestModel.fromMap(Map<String, dynamic> map) {
    return MunicipioRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['isActivo'],
      codigoDane: map['codigoDane'],
      fechaCreacion: map['fechaCreacion'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      codigoUsuario: map['codigoUsuario'],
      nombreUsuario: map['nombreUsuario'],
      codigoDepartamento: map['departamento'],
      codigoPais: map['pais'],
    );
  }

  factory MunicipioRequestModel.fromRequest(MunicipioRequest request) {
    return MunicipioRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      codigoDane: request.codigoDane,
      fechaCreacion: request.fechaCreacion,
      latitud: request.latitud,
      longitud: request.longitud,
      codigoUsuario: request.codigoUsuario,
      nombreUsuario: request.nombreUsuario,
      codigoDepartamento: request.codigoDepartamento,
      codigoPais: request.codigoPais,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': isActivo,
      'fechaCreacion': fechaCreacion,
      'latitud': latitud,
      'longitud': longitud,
      'codigoUsuario': codigoUsuario,
      'codigoDane': codigoDane,
      'nombreUsuario': nombreUsuario,
      'codigoDepartamento': codigoDepartamento,
      'codigoPais': codigoPais,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
