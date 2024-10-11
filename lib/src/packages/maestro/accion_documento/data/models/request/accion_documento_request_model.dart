import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';

class AccionDocumentoRequestModel extends AccionDocumentoRequest {
  AccionDocumentoRequestModel({
    super.codigo,
    super.isActivo,
    super.isNaturalezaInversa,
    super.nombre,
    super.tipoDocumento,
    super.usuario,
  });

  factory AccionDocumentoRequestModel.fromMap(Map<String, dynamic> map) => AccionDocumentoRequestModel(
        nombre: map['nombre'],
        codigo: map['codigo'],
        tipoDocumento: map['tipoDocumento'],
        isNaturalezaInversa: map['isNaturalezaInversa'],
        isActivo: map['isActivo'],
      );
}
