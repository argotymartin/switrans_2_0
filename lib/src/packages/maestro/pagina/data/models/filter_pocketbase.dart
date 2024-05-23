import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';

class FilterPocketBase extends PaginaRequest {
  String toPocketBaseFilter(PaginaRequest request) {
    final List<String> conditions = <String>[];
    if (request.paginaTexto != null && request.paginaTexto!.isNotEmpty) {
      conditions.add('pagina_texto ~ "${request.paginaTexto!}"');
    }
    if (request.paginaCodigo != null) {
      conditions.add('pagina_codigo = ${request.paginaCodigo!}');
    }
    if (request.paginaVisible != null) {
      conditions.add('pagina_visible = ${request.paginaVisible!}');
    }
    if (request.paginaActivo != null) {
      conditions.add('pagina_activo = ${request.paginaActivo!}');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  String formatToYYYYMMDD(String fecha) {
    return fecha.replaceAll(RegExp(r'/'), '-');
  }
}
