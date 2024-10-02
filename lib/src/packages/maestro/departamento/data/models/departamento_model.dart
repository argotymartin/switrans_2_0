import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento.dart';

class DepartamentoModel extends Departamento {
  DepartamentoModel({
    required super.codigo,
    required super.nombre,
    required super.pais,
    required super.codigoUsuario,
    required super.estado,
    required super.fechaCreacion,
    super.codigoDane,
  });

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) => DepartamentoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        pais: json['codigoPais'],
        codigoUsuario: json['codigoUsuario'],
        codigoDane: json['codigoDane'],
        estado: json['estado'],
        fechaCreacion: json['fechaCreacion'].toString(),
      );
}
