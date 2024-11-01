import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';

class TipoImpuestoRequestModel extends TipoImpuestoRequest {
  TipoImpuestoRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
  });

  factory TipoImpuestoRequestModel.fromMap(Map<String, dynamic> map) {
    return TipoImpuestoRequestModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      isActivo: map['isActivo'],
      fechaCreacion: map['fechaCreacion'],
      codigoUsuario: map['codigoUsuario'],
      nombreUsuario: map['nombreUsuario'],
    );
  }

  factory TipoImpuestoRequestModel.fromRequest(TipoImpuestoRequest request) {
    return TipoImpuestoRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      nombreUsuario: request.nombreUsuario,
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
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
