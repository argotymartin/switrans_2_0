import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';

class PaginaRequestModel extends PaginaRequest {
  PaginaRequestModel({
    required super.codigo,
    required super.nombre,
    required super.path,
    required super.modulo,
    required super.isVisible,
    required super.isActivo,
  });

  factory PaginaRequestModel.fromRequestPB(PaginaRequest request) {
    return PaginaRequestModel(
      codigo: request.codigo,
      nombre: request.nombre,
      path: request.path,
      modulo: request.modulo,
      isVisible: request.isVisible,
      isActivo: request.isActivo,
    );
  }

  factory PaginaRequestModel.fromTable(Map<String, dynamic> map) => PaginaRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        path: map['path'],
        modulo: map['modulo'],
        isVisible: map['visible'],
        isActivo: map['activo'],
      );

  Map<String, dynamic> toJsonPB() {
    return <String, dynamic>{
      'pagina_codigo': codigo,
      'pagina_texto': nombre,
      'pagina_path': path,
      'modulo': modulo,
      'pagina_visible': isVisible,
      'pagina_activo': isActivo,
    };
  }

  static String toPocketBaseFilter(Map<String, dynamic> map) {
    final List<String> conditions = <String>[];
    if (map["pagina_texto"] != null) {
      conditions.add('pagina_texto = "${map["pagina_texto"]}"');
    }
    if (map["pagina_codigo"] != null) {
      conditions.add('pagina_codigo = ${map["pagina_codigo"]}');
    }
    if (map["pagina_visible"] != null) {
      conditions.add('pagina_visible = ${map["pagina_visible"]}');
    }
    if (map["pagina_activo"] != null) {
      conditions.add('pagina_activo = ${map["pagina_activo"]}');
    }
    if (map["modulo"] != null) {
      conditions.add('modulo = "${map["modulo"]}"');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }
}
