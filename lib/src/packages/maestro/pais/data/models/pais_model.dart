import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';

class PaisModel extends Pais {
  PaisModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
  });

  factory PaisModel.fromJson(Map<String, dynamic> json) => PaisModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        isActivo: json['activo'],
        fechaCreacion: json['updated'],
      );
}
