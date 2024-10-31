import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/domain.dart';

class AccionDocumentoRequestModel extends AccionDocumentoRequest {
  AccionDocumentoRequestModel({
    super.codigo,
    super.nombre,
    super.isActivo,
    super.isInversa,
    super.isReversible,
    super.fechaCreacion,
    super.codigoUsuario,
    super.nombreUsuario,
    super.codigoDocumento,
    super.nombreDocumento,
  });

  factory AccionDocumentoRequestModel.fromMap(Map<String, dynamic> map) => AccionDocumentoRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        isActivo: map['isActivo'],
        isInversa: map['isInversa'],
        isReversible: map['isReversible'],
        fechaCreacion: map['fechaCreacion'],
        codigoUsuario: map['codigoUsuario'],
        nombreUsuario: map['nombreUsuario'],
        codigoDocumento: map['codigoDocumento'],
        nombreDocumento: map['nombreDocumento'],
      );

  factory AccionDocumentoRequestModel.fromRequest(AccionDocumentoRequest request) {
    return AccionDocumentoRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      isActivo: request.isActivo,
      isInversa: request.isInversa,
      isReversible: request.isReversible,
      fechaCreacion: request.fechaCreacion,
      codigoUsuario: request.codigoUsuario,
      nombreUsuario: request.nombreUsuario,
      codigoDocumento: request.codigoDocumento,
      nombreDocumento: request.nombreDocumento,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': isActivo,
      'estadoNaturaleza': isInversa,
      'estadoReversible': isReversible,
      'fechaCreacion': fechaCreacion,
      'codigoUsuario': codigoUsuario,
      'nombreUsuario': nombreUsuario,
      'codigoDocumento': codigoDocumento,
      'nombreDocumento': nombreDocumento,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
