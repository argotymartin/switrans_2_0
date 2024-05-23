import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';

class PaginaModel extends Pagina {
  PaginaModel({
    required super.id,
    required super.paginaCodigo,
    required super.paginaTexto,
    required super.paginaPath,
    required super.paginaVisible,
    required super.paginaActivo,
    required super.fechaCreacion,
  });

  factory PaginaModel.fromJson(Map<String, dynamic> json) => PaginaModel(
        id: json["id"],
        paginaCodigo: json["pagina_codigo"],
        paginaTexto: json["pagina_texto"],
        paginaPath: json["pagina_path"],
        paginaVisible: json["pagina_visible"],
        paginaActivo: json["pagina_activo"],
        fechaCreacion: json["created"].toString(),
      );
}
