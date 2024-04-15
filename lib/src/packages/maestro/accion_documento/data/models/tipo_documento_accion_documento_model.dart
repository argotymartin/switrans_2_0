import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';

class TipoDocumentoAccionDocumentoModel extends TipoDocumentoAccionDocumento {
  TipoDocumentoAccionDocumentoModel({required super.codigo, required super.nombre});

  factory TipoDocumentoAccionDocumentoModel.fromJson(Map<String, dynamic> json) => TipoDocumentoAccionDocumentoModel(
        codigo: json['documento_codigo'],
        nombre: json['documento_nombre'],
      );
}
