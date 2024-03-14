import 'package:switrans_2_0/src/globals/menu/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';

class PaqueteModel extends Paquete {
  PaqueteModel({
    required super.id,
    required super.nombre,
    required super.codigo,
    required super.icono,
    required super.visible,
    required super.modulos,
    required super.path,
  });

  factory PaqueteModel.fromJson(Map<String, dynamic> json) => PaqueteModel(
        id: json['id'],
        nombre: json['nombre'],
        codigo: json['codigo'],
        icono: json['icono'],
        path: json['path'],
        visible: json['visible'],
        modulos: List<ModuloModel>.from(json['modulos'].map((x) => ModuloModel.fromJson(x))),
      );
}
