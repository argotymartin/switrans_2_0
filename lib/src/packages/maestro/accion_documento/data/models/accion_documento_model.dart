import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/accion_documento.dart';

class AccionDocumentoModel extends AccionDocumento {
  AccionDocumentoModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.isInversa,
    required super.isReversible,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.codigoDocumento,
    required super.nombreDocumento,
  });

  factory AccionDocumentoModel.fromJson(Map<String, dynamic> json) => AccionDocumentoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        isActivo: json['estado'],
        isInversa: json['estadoNaturaleza'],
        isReversible: json['estadoReversible'],
        fechaCreacion: json['fechaCreacion'].replaceAll('T', ' ').replaceAll('Z', ''),
        codigoUsuario: json['codigoUsuario'],
        nombreUsuario: json['nombreUsuario'],
        codigoDocumento: json['codigoDocumento'],
        nombreDocumento: json['nombreDocumento'],
      );
}
