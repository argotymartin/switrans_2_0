import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';

class UnidadNegocioModel extends UnidadNegocio {
  UnidadNegocioModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.usuario,
    required super.empresa,
  });

  factory UnidadNegocioModel.fromDB(Map<String, dynamic> map) => UnidadNegocioModel(
        codigo: map['unineg_codigo'],
        nombre: map['unineg_nombre'],
        isActivo: map['unineg_activo'],
        fechaCreacion: map['unineg_fechacreacion'].toString(),
        usuario: map['usuario'],
        empresa: map['empresa'],
      );

  factory UnidadNegocioModel.fromJson(Map<String, dynamic> map) => UnidadNegocioModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        isActivo: map['isActivo'],
        fechaCreacion: map['fechaCreacion'].toString(),
        usuario: map['usuario'],
        empresa: map['empresa'],
      );
}
