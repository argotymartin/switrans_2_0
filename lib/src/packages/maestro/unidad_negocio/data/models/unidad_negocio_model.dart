import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';

class UnidadNegocioModel extends UnidadNegocio {
  UnidadNegocioModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.nombreEmpresa,
    required super.codigoEmpresa,
  });

  factory UnidadNegocioModel.fromJson(Map<String, dynamic> map) => UnidadNegocioModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        isActivo: map['estado'],
        fechaCreacion: map['fechaCreacion'].toString().replaceAll('T', ' '),
        codigoUsuario: map["codigoUsuario"],
        nombreUsuario: map["nombreUsuario"],
        nombreEmpresa: map["nombreEmpresa"],
        codigoEmpresa: map["codigoEmpresa"],
      );
}
