import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento.dart';

class DepartamentoModel extends Departamento {
  DepartamentoModel({
    required super.codigo,
    required super.nombre,
    required super.pais,
    required super.codigoUsuario,
    super.codigoDane,
    required super.isActivo,
    required super.fechaCreacion,
  });

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) => DepartamentoModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        pais: json['codigoPais'],
        codigoUsuario: json['codigoUsuario'],
        codigoDane: json['codigoDane'],
        isActivo: json['activo'],
        fechaCreacion: json['fechaCreacion'].toString(),
      );

  factory DepartamentoModel.fromRequestAPI(Departamento departamento) {
    return DepartamentoModel(
      codigo: departamento.codigo,
      nombre: departamento.nombre,
      pais: departamento.pais,
      codigoUsuario: departamento.codigoUsuario,
      codigoDane: departamento.codigoDane,
      isActivo: departamento.isActivo,
      fechaCreacion: '',
    );
  }

  factory DepartamentoModel.fromAPIResponse(Map<String, dynamic> map) {
    return DepartamentoModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      pais: map['pais'],
      codigoUsuario: map['codigoUsuario'],
      codigoDane: map['codigoDane'],
      isActivo: map['activo'],
      fechaCreacion: '',
    );
  }

  Map<String, dynamic> toJsonAPI() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'pais': pais,
      'codigoUsuario': codigoUsuario,
      'codigoDane': codigoDane,
      'isActivo': isActivo,
    };
  }
}
