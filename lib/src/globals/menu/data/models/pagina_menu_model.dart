import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';

class PaginaMenuModel extends PaginaMenu {
  PaginaMenuModel({
    required super.id,
    required super.modulo,
    required super.codigo,
    required super.texto,
    required super.path,
  });

  factory PaginaMenuModel.fromJson(Map<String, dynamic> json) => PaginaMenuModel(
        id: json["id"],
        modulo: json["modulo"],
        codigo: json["codigo"],
        texto: json["texto"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "modulo": modulo,
        "codigo": codigo,
        "texto": texto,
        "path": path,
      };

  factory PaginaMenuModel.fromJsonPocketbase(Map<String, dynamic> json) => PaginaMenuModel(
        id: json["id"],
        modulo: json["modulo"],
        codigo: json["pagina_codigo"],
        texto: json["pagina_texto"],
        path: json["pagina_path"],
      );
}
