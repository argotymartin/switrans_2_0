import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';

class UnidadNegocioRequestModel extends UnidadNegocioRequest {
  UnidadNegocioRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.codigoEmpresa,
  });

  factory UnidadNegocioRequestModel.fromMap(Map<String, dynamic> map) {
    return UnidadNegocioRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['isActivo'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
      nombreUsuario: map['nombreUsuario'],
      codigoEmpresa: map['codigoEmpresa'],
    );
  }

  factory UnidadNegocioRequestModel.fromRequest(UnidadNegocioRequest request) {
    return UnidadNegocioRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      nombreUsuario: request.nombreUsuario,
      codigoEmpresa: request.codigoEmpresa,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': isActivo,
      'fechaCreacion': fechaCreacion,
      'codigoUsuario': codigoUsuario,
      'nombreUsuario': nombreUsuario,
      'codigoEmpresa': codigoEmpresa,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
