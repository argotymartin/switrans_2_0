import 'package:switrans_2_0/src/modules/menu/domain/entities/pagina.dart';

class PaginaModel extends Pagina {
  PaginaModel({
    required super.id,
    required super.modulo,
    required super.paginaCodigo,
    required super.paginaTexto,
    required super.paginaVisible,
  });

  factory PaginaModel.fromJson(Map<String, dynamic> json) => PaginaModel(
        id: json["id"],
        modulo: json["modulo"],
        paginaCodigo: json["pagina_codigo"],
        paginaTexto: json["pagina_texto"],
        paginaVisible: json["pagina_visible"],
      );
}
