import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';

class FilterPocketBase extends ModuloRequest {
  String toPocketBaseFilter(ModuloRequest request) {
    final List conditions = [];
    if (request.moduloNombre != null && request.moduloNombre!.isNotEmpty) conditions.add('modulo_nombre ~ "${request.moduloNombre!}"');
    if (request.moduloCodigo != null) conditions.add('modulo_codigo = ${request.moduloCodigo!}');
    if (request.paquete != null && request.paquete!.isNotEmpty) conditions.add('paquete = "${request.paquete!}"');
    if (request.moduloVisible != null) conditions.add('modulo_visible = ${request.moduloVisible!}');
    if (request.moduloActivo != null) conditions.add('modulo_activo = ${request.moduloActivo!}');
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  String formatToYYYYMMDD(String fecha) {
    return fecha.replaceAll(RegExp(r'/'), '-');
  }

}