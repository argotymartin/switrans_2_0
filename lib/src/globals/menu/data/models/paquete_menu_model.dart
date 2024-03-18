import 'package:switrans_2_0/src/globals/menu/data/models/modulo_menu_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';

class PaqueteMenuModel extends PaqueteMenu {
  PaqueteMenuModel({
    required super.id,
    required super.nombre,
    required super.codigo,
    required super.icono,
    required super.visible,
    required super.modulos,
    required super.path,
  });

  factory PaqueteMenuModel.fromJson(Map<String, dynamic> json) => PaqueteMenuModel(
        id: json['id'],
        nombre: json['nombre'],
        codigo: json['codigo'],
        icono: json['icono'],
        path: json['path'],
        visible: json['visible'],
        modulos: List<ModuloMenuModel>.from(json['modulos'].map((x) => ModuloMenuModel.fromJson(x))),
      );
}
