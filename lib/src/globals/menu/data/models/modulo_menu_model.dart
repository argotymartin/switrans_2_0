import 'package:switrans_2_0/src/globals/menu/data/models/pagina_menu_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo_menu.dart';

class ModuloMenuModel extends ModuloMenu {
  ModuloMenuModel({
    required super.codigo,
    required super.icono,
    required super.texto,
    required super.path,
    required super.paquete,
    super.detalles,
    super.paginas,
  });

  factory ModuloMenuModel.fromJson(Map<String, dynamic> json) => ModuloMenuModel(
        codigo: json['modulo_codigo'],
        icono: json['modulo_icono'],
        texto: json['modulo_nombre'],
        path: json['modulo_path'],
        paquete: json['paquete'],
        detalles: json['modulo_detalles'],
        paginas: List<PaginaMenuModel>.from(json['paginas'].map((x) => PaginaMenuModel.fromJson(x))),
      );
}
