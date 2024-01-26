import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina.dart';

class PaginaModel extends Pagina {
  PaginaModel({
    required super.id,
    required super.modulo,
    required super.codigo,
    required super.texto,
    required super.path,
  });

  factory PaginaModel.fromJson(Map<String, dynamic> json) => PaginaModel(
        id: json["id"],
        modulo: json["modulo"],
        codigo: json["pagina_codigo"],
        texto: json["pagina_texto"],
        path: json["pagina_path"],
      );
}
