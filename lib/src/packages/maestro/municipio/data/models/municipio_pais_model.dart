import 'package:switrans_2_0/src/packages/maestro/municipio/domain/entities/municipio_pais.dart';

class MunicipioPaisModel extends MunicipioPais {
  MunicipioPaisModel({required super.codigo, required super.nombre});

  factory MunicipioPaisModel.fromJson(Map<String, dynamic> json) => MunicipioPaisModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
      );
}
