import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/accion_documento_documento.dart';

class AccionDocumentoDocumentoModel extends AccionDocumentoDocumento {
  AccionDocumentoDocumentoModel({required super.codigo, required super.nombre});

  factory AccionDocumentoDocumentoModel.fromJson(Map<String, dynamic> json) => AccionDocumentoDocumentoModel(
    codigo: json['codigo'],
    nombre: json['nombre'],
  );
}
