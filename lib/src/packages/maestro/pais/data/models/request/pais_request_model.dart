import 'package:switrans_2_0/src/packages/maestro/pais/domain/domain.dart';

class PaisRequestModel extends PaisRequest {
  PaisRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.usuarioNombre,

  });

  factory PaisRequestModel.fromTable(Map<String, dynamic> map) {
    return PaisRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['activo'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
      usuarioNombre: map['usuarioNombre'],
    );
  }

  factory PaisRequestModel.fromRequest(PaisRequest request) {
    return PaisRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      usuarioNombre: request.usuarioNombre,
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
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
