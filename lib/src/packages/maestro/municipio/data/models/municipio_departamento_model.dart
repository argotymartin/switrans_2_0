import 'package:switrans_2_0/src/packages/maestro/municipio/domain/entities/municipio_departamento.dart';

class MunicipioDepartamentoModel extends MunicipioDepartamento {
  MunicipioDepartamentoModel({required super.codigo, required super.nombre});

  factory MunicipioDepartamentoModel.fromJson(Map<String, dynamic> json) => MunicipioDepartamentoModel(
        codigo: json['departamento_codigo'],
        nombre: json['departamento_nombre'],
      );
}
