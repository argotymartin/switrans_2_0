import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';

class AccionDocumentoModel extends AccionDocumento {
  AccionDocumentoModel({
    required super.codigo,
    required super.nombre,
    required super.tipoNombre,
    required super.tipoCodigo,
    required super.isActivo,
    required super.isInverso,
    required super.usuario,
    required super.fechaCreacion,
    required super.fechaActualizacion,
  });

  factory AccionDocumentoModel.fromJson(Map<String, dynamic> json) => AccionDocumentoModel(
        codigo: json['accdoc_codigo'],
        nombre: json['accdoc_nombre'],
        usuario: json['usuario_nombre'],
        fechaCreacion: json['accdoc_fecha_creacion'].toString(),
        fechaActualizacion: json['accdoc_fecha_modificacion'].toString(),
        tipoNombre: json['documento_nombre'],
        tipoCodigo: json['documento_codigo'],
        isActivo: json['accdoc_es_activo'],
        isInverso: json['accdoc_es_naturaleza_inversa'],
      );
}
