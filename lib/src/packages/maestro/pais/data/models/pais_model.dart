import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';

class PaisModel extends Pais {
  PaisModel({
    required super.codigo,
    required super.nombre,
    required super.estado,
    required super.fechaCreacion,
  });

  factory PaisModel.fromJson(Map<String, dynamic> json) => PaisModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        estado: json['estado'],
        fechaCreacion: json['fechaCreacion'].toString(),
      );

  factory PaisModel.fromRequestAPI(Pais pais) {
    return PaisModel(
      codigo: pais.codigo,
      nombre: pais.nombre,
      estado: pais.estado,
      fechaCreacion: '',
    );
  }

  factory PaisModel.fromAPIResponse(Map<String, dynamic> map) {
    return PaisModel(
      codigo: map['codigo'],
      nombre: map['nombre'],
      estado: map['estado'],
      fechaCreacion: '',
    );
  }

  Map<String, dynamic> toJsonAPI() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'estado': estado,
    };
  }
}
