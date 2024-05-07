class ModuloRequest {
  final String? moduloId;
  late int? moduloCodigo;
  final String? moduloNombre;
  final String? moduloDetalles;
  late String? moduloPath;
  final bool? moduloVisible;
  final String? moduloIcono;
  late String? paquete;
  final bool? moduloActivo;

  ModuloRequest({
    this.moduloId,
    this.moduloCodigo,
    this.moduloNombre,
    this.moduloDetalles,
    this.moduloPath,
    this.moduloVisible,
    this.moduloIcono,
    this.paquete,
    this.moduloActivo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': '$moduloId',
      'modulo_codigo': moduloCodigo,
      'modulo_nombre': "$moduloNombre",
      'modulo_detalles': '$moduloDetalles',
      'modulo_path': '$moduloPath',
      'modulo_visible': moduloVisible,
      'modulo_icono': '$moduloIcono',
      'paquete': paquete,
      'modulo_activo': moduloActivo,
    };
    if (moduloId != '0') {
      data['id'] = '$moduloId';
    }
    if (moduloCodigo != 0) {
      data['modulo_codigo'] = moduloCodigo;
    }
    if (moduloNombre!.isEmpty) {
      data['modulo_nombre'] = '$moduloNombre';
    }
    if (moduloDetalles!.isEmpty) {
      data['modulo_detalles'] = '$moduloDetalles';
    }
    if (moduloPath!.isEmpty) {
      data['modulo_path'] = '$moduloPath';
    }
    if (moduloVisible != null) {
      data['modulo_visible'] = moduloVisible;
    }
    if (moduloIcono!.isEmpty) {
      data['modulo_icono'] = '$moduloIcono';
    }
    if (paquete!.isEmpty) {
      data['paquete'] = paquete;
    }
    if (moduloActivo != null) {
      data['modulo_activo'] = moduloActivo;
    }

    return data;
  }

  Map<String, dynamic> toJsonCreate() {
    return {
      'modulo_codigo': moduloCodigo,
      'modulo_nombre': moduloNombre,
      'modulo_detalles': moduloDetalles,
      'modulo_path': moduloPath,
      'modulo_visible': moduloVisible,
      'modulo_icono': moduloIcono,
      'paquete': paquete,
      'modulo_activo': moduloActivo,
    };
  }

  factory ModuloRequest.fromMap(Map<String, dynamic> map) => ModuloRequest(
        moduloId: map['id'],
        moduloCodigo: map['codigo'],
        moduloNombre: map['nombre'],
        moduloDetalles: map['detalles'],
        moduloPath: map['path'],
        moduloVisible: map['visible'],
        moduloIcono: map['icono'],
        paquete: map['paquete'],
        moduloActivo: map['activo'],
      );
}
