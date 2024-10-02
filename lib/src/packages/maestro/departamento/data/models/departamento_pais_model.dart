import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento_pais.dart';

class DepartamentoPaisModel extends DepartamentoPais {
  DepartamentoPaisModel({required super.codigo, required super.nombre});

  factory DepartamentoPaisModel.fromJson(Map<String, dynamic> json) => DepartamentoPaisModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
      );
}
