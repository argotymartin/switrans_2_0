import 'package:switrans_2_0/src/modules/menu/data/models/pagina_model.dart';
import 'package:switrans_2_0/src/modules/menu/domain/entities/modulo.dart';

class ModuloModel extends Modulo {
  ModuloModel({
    required super.moduloCodigo,
    required super.moduloIcono,
    required super.moduloTexto,
    required super.moduloVisible,
    super.paginas,
  });

  factory ModuloModel.fromJson(Map<String, dynamic> json) => ModuloModel(
        moduloCodigo: json['modulo_codigo'],
        moduloIcono: json['modulo_icono'],
        moduloTexto: json['modulo_texto'],
        moduloVisible: json['modulo_visible'],
        paginas: List<PaginaModel>.from(json['paginas'].map((x) => PaginaModel.fromJson(x))),
      );
}
