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
      final String moduloTexto = map["pagina_texto"];
      conditions.add('pagina_texto = "$moduloTexto"');
    }
    if (map["pagina_codigo"] != null) {
      final int paginaCodigo = map["pagina_codigo"];
      conditions.add('pagina_codigo = $paginaCodigo');
    }
    if (map["pagina_visible"] != null) {
      final bool paginaVisible = map["pagina_visible"];
      conditions.add('pagina_visible = $paginaVisible');
    }
    if (map["pagina_activo"] != null) {
      final String moduloActivo = map["pagina_activo"];
      conditions.add('pagina_activo = $moduloActivo');
    }

    if (map["modulo"] != null) {
      final String modulo = map["modulo"];
      conditions.add('modulo = "$modulo"');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }
}
