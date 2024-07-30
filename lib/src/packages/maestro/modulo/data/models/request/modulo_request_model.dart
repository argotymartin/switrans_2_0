import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';

class ModuloRequestModel extends ModuloRequest {
  ModuloRequestModel({
    super.codigo,
    super.nombre,
    super.detalle,
    super.path,
    super.isVisible,
    super.icono,
    super.paquete,
    super.isActivo,
  });

  factory ModuloRequestModel.fromRequestPB(ModuloRequest request) {
    return ModuloRequestModel(
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
    final Map<String, dynamic> data = <String, dynamic>{
      'modulo_codigo': codigo,
      'modulo_nombre': nombre,
      'modulo_detalles': detalle,
      'modulo_path': path,
      'modulo_visible': isVisible,
      'modulo_icono': icono,
      'paquete': paquete,
      'modulo_activo': isActivo,
    };
    return data;
  }

  static String toPocketBaseFilter(Map<String, dynamic> map) {
    final List<String> conditions = <String>[];
    if (map["modulo_nombre"] != null) {
      final String moduloNombre = map["modulo_nombre"];
      conditions.add('modulo_nombre = "$moduloNombre"');
    }
    if (map["modulo_codigo"] != null) {
      final int moduloCodigo = map["modulo_codigo"];
      conditions.add('modulo_codigo = $moduloCodigo');
    }
    if (map["paquete"] != null) {
      final String paquete = map["paquete"];
      conditions.add('paquete = "$paquete"');
    }
    if (map["modulo_visible"] != null) {
      final bool moduloVisible = map["modulo_visible"];
      conditions.add('modulo_visible = $moduloVisible');
    }
    if (map["modulo_activo"] != null) {
      final bool moduloActivo = map["modulo_activo"];
      conditions.add('modulo_activo = $moduloActivo');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  factory ModuloRequestModel.fromTable(Map<String, dynamic> map) => ModuloRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        detalle: map['detalles'],
        path: map['path'],
        isVisible: map['visible'],
        icono: map['icono'],
        paquete: map["paquete"],
        isActivo: map['activo'],
      );
}
