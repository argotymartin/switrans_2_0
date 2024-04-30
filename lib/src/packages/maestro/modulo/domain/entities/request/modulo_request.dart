class ModuloRequest {
  final String? moduloId;
  late  int? moduloCodigo;
  final String? moduloNombre;
  final String? moduloDetalles;
  late  String? moduloPath;
  final bool? moduloVisible;
  final String? moduloIcono;
  final String? fechaInicial;
  final String? fechaFinal;
  late  String? paquete;

  ModuloRequest({
    this.moduloId,
    this.moduloCodigo,
    this.moduloNombre,
    this.moduloDetalles,
    this.moduloPath,
    this.moduloVisible,
    this.moduloIcono,
    this.fechaInicial,
    this.fechaFinal,
    this.paquete
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
      'paquete': paquete
    };
    if (moduloId != 0) data['id'] = '$moduloId';
    if (moduloCodigo != 0) data['modulo_codigo'] = moduloCodigo;
    if (moduloNombre!.isEmpty) data['modulo_nombre'] = '$moduloNombre';
    if (moduloDetalles!.isEmpty) data['modulo_detalles'] = '$moduloDetalles';
    if (moduloPath!.isEmpty) data['modulo_path'] = '$moduloPath';
    if (moduloVisible != null) data['modulo_visible'] = moduloVisible;
    if (moduloIcono!.isEmpty) data['modulo_icono'] = '$moduloIcono';
    if (paquete!.isEmpty) data['paquete'] = paquete;

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
      'paquete': paquete
    };
  }

  String toPocketBaseFilter() {
    final List conditions = [];
    if (moduloNombre != null && moduloNombre!.isNotEmpty) conditions.add('modulo_nombre ~ "${moduloNombre!}"');
    if (moduloCodigo != null) conditions.add('modulo_codigo = ${moduloCodigo!}');
    if (fechaInicial != null && fechaFinal != null && fechaInicial!.isNotEmpty && fechaFinal!.isNotEmpty) {
      final formattedFechaInicial = formatToYYYYMMDD(fechaInicial!.toString());
      final formattedFechaFinal = formatToYYYYMMDD(fechaFinal!.toString());
      conditions.add('created >= "$formattedFechaInicial" && created <= "$formattedFechaFinal"');
    }
    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  String formatToYYYYMMDD(String fecha) {
    return fecha.replaceAll(RegExp(r'/'), '-');
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
  );

}