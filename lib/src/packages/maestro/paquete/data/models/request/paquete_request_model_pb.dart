import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';

class PaqueteRequestModelPB extends PaqueteRequest {
  PaqueteRequestModelPB({
    required super.codigo,
    required super.nombre,
    required super.path,
    required super.isVisible,
    required super.isActivo,
    required super.icono,
  });

  factory PaqueteRequestModelPB.fromRequestPB(PaqueteRequest request) => PaqueteRequestModelPB(
        codigo: request.codigo,
        nombre: request.nombre,
        path: request.path,
        isVisible: request.isVisible,
        isActivo: request.isActivo,
        icono: request.icono,
      );

  Map<String, dynamic> toJsonPB() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'path': path,
      'visible': isVisible,
      'activo': isActivo,
      'icono': icono,
    };
  }

  static String toPocketBaseFilter(Map<String, dynamic> map) {
    final List<String> conditions = <String>[];
    if (map["nombre"] != null) {
      conditions.add('nombre ~ "${map["nombre"]}"');
    }
    if (map["codigo"] != null) {
      conditions.add('codigo = ${map["codigo"]}');
    }
    if (map["visible"] != null) {
      conditions.add('visible = ${map["visible"]}');
    }
    if (map["activo"] != null) {
      conditions.add('activo = ${map["activo"]}');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }
}
