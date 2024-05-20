import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';

class FilterPocketBase extends PaqueteRequest {
  String toPocketBaseFilter(PaqueteRequest request) {
    final List<String> conditions = <String>[];
    if (request.paqueteNombre != null && request.paqueteNombre!.isNotEmpty) {
      conditions.add('nombre ~ "${request.paqueteNombre!}"');
    }
    if (request.paqueteCodigo != null) {
      conditions.add('codigo = ${request.paqueteCodigo!}');
    }
    if (request.paqueteVisible != null) {
      conditions.add('visible = ${request.paqueteVisible!}');
    }
    if (request.paqueteActivo != null) {
      conditions.add('activo = ${request.paqueteActivo!}');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  String formatToYYYYMMDD(String fecha) {
    return fecha.replaceAll(RegExp(r'/'), '-');
  }
}
