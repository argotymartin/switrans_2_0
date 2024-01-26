import 'package:switrans_2_0/src/globals/menu/data/models/pagina_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo.dart';

class ModuloModel extends Modulo {
  ModuloModel({
    required super.codigo,
    required super.icono,
    required super.texto,
    required super.path,
    super.paginas,
  });

  factory ModuloModel.fromJson(Map<String, dynamic> json) => ModuloModel(
        codigo: json['modulo_codigo'],
        icono: json['modulo_icono'],
        texto: json['modulo_texto'],
        path: json['modulo_path'],
        paginas: List<PaginaModel>.from(json['paginas'].map((x) => PaginaModel.fromJson(x))),
      );
}
