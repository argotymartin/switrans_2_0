import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento.dart';

class DepartamentoModel extends Departamento {
  DepartamentoModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombrePais,
    required super.codigoPais,
    super.codigoDane,
  });

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) => DepartamentoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        isActivo: json['estado'],
        codigoDane: json['codigoDane'],
        fechaCreacion: json['fechaCreacion'].toString(),
        codigoUsuario: json['codigoUsuario'],
        nombrePais: json['nombrePais'],
        codigoPais: json['codigoPais'],
      );
}
