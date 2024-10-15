import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';

class ModuloRequestModelPB extends ModuloRequest {
  ModuloRequestModelPB({
    super.codigo,
    super.nombre,
    super.detalle,
    super.path,
    super.isVisible,
    super.icono,
    super.paquete,
    super.isActivo,
  });

  factory ModuloRequestModelPB.fromRequestPB(ModuloRequest request) {
    return ModuloRequestModelPB(
      codigo: request.codigo,
      nombre: request.nombre,
      detalle: request.detalle,
      icono: request.icono,
      isActivo: request.isActivo,
      isVisible: request.isVisible,
      paquete: request.paquete,
      path: request.path,
    );
  }

  Map<String, dynamic> toJsonPB() {
    return <String, dynamic>{
      'modulo_codigo': codigo,
      'modulo_nombre': nombre,
      'modulo_detalles': detalle,
      'modulo_path': path,
      'modulo_visible': isVisible,
      'modulo_icono': icono,
      'paquete': paquete,
      'modulo_activo': isActivo,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  static String toPocketBaseFilter(Map<String, dynamic> map) {
    final List<String> conditions = <String>[];
    if (map["modulo_nombre"] != null) {
      conditions.add('modulo_nombre ~ "${map["modulo_nombre"]}"');
    }
    if (map["modulo_codigo"] != null) {
      conditions.add('modulo_codigo = ${map["modulo_codigo"]}');
    }
    if (map["paquete"] != null) {
      conditions.add('paquete = "${map["paquete"]}"');
    }
    if (map["modulo_visible"] != null) {
      conditions.add('modulo_visible = ${map["modulo_visible"]}');
    }
    if (map["modulo_activo"] != null) {
      conditions.add('modulo_activo = ${map["modulo_activo"]}');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }
}
