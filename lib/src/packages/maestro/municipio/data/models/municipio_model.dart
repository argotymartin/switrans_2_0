import 'package:switrans_2_0/src/packages/maestro/municipio/domain/entities/municipio.dart';

class MunicipioModel extends Municipio {
  MunicipioModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.codigoDepartamento,
    required super.nombreDepartamento,
    required super.codigoPais,
    required super.nombrePais,
    super.codigoDane,
  });

  factory MunicipioModel.fromJson(Map<String, dynamic> json) => MunicipioModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        isActivo: json["estado"],
        codigoDane: json["codigoDane"] ?? "",
        fechaCreacion: json["fechaCreacion"].toString(),
        codigoUsuario: json["codigoUsuario"],
        nombreUsuario: json["nombreUsuario"],
        codigoDepartamento: json["codigoDepartamento"],
        nombreDepartamento: json["nombreDepartamento"],
        codigoPais: json["codigoPais"],
        nombrePais: json["nombrePais"],
      );
}
