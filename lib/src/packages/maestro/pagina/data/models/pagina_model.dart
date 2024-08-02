import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';

class PaginaModel extends Pagina {
  PaginaModel({
    required super.codigo,
    required super.texto,
    required super.path,
    required super.isVisible,
    required super.isActivo,
    required super.modulo,
    required super.fechaCreacion,
  });

  factory PaginaModel.fromJson(Map<String, dynamic> json) => PaginaModel(
        codigo: json["pagina_codigo"],
        texto: json["pagina_texto"],
        path: json["pagina_path"],
        isVisible: json["pagina_visible"],
        isActivo: json["pagina_activo"],
        modulo: json["expand"]["modulo"]["modulo_codigo"],
        fechaCreacion: json["created"].toString(),
      );
}
