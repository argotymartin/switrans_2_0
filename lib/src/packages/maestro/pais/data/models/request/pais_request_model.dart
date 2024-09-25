import 'package:switrans_2_0/src/packages/maestro/pais/domain/domain.dart';

class PaisRequestModel extends PaisRequest {
  PaisRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
  });

  factory PaisRequestModel.fromRequestPB(PaisRequest request) {
    return PaisRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
    );
  }

  Map<String, dynamic> toJsonPB() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'activo': isActivo,
    };
  }

  factory PaisRequestModel.fromTable(Map<String, dynamic> map) {
    return PaisRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['activo'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
    );
  }

  factory PaisRequestModel.fromRequestAPI(PaisRequest request) {
    return PaisRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
    );
  }

  Map<String, dynamic> toJsonAPI() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': isActivo,
      'fechaCreacion': fechaCreacion,
      'codigoUsuario': codigoUsuario,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
