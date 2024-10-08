import 'package:switrans_2_0/src/packages/maestro/municipio/domain/entities/municipio.dart';

class MunicipioModel extends Municipio {
  MunicipioModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.departamento,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.usuarioNombre,
  });

  factory MunicipioModel.fromJson(Map<String, dynamic> json) => MunicipioModel(
        codigo: json["municipio_codigo"],
        nombre: json["municipio_nombre"],
        isActivo: json["municipio_activo"],
        departamento: json["expand"]["departamento"]["departamento_codigo"],
        fechaCreacion: json["created"].toString(),
        codigoUsuario: json["codigoUsuario"],
        usuarioNombre: json["usuarioNombre"],
      );
}
