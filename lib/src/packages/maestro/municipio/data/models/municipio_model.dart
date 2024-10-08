import 'package:switrans_2_0/src/packages/maestro/municipio/domain/entities/municipio.dart';

class MunicipioModel extends Municipio {
  MunicipioModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.departamento,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
  });

  factory MunicipioModel.fromJson(Map<String, dynamic> json) => MunicipioModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        isActivo: json["estado"],
        departamento: json["codigoDepartamento"],
        fechaCreacion: json["fechaCreacion"],
        codigoUsuario: json["codigoUsuario"] != null ? json["codigoUsuario"] : null,
        nombreUsuario: json["nombreUsuario"],
      );
}
