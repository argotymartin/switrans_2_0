class TipoImpuestoRequest {
  final int? codigo;
  final int? usuario;
  final String? nombre;
  final String? fechaInicio;
  final String? fechaFin;

  TipoImpuestoRequest({
    this.nombre,
    this.usuario,
    this.codigo,
    this.fechaInicio,
    this.fechaFin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'usuario': usuario,
      'nombre': nombre,
    };
    if (codigo != 0) {
      data['codigo'] = codigo;
    }

    return data;
  }

  String toPocketBaseFilter() {
    final List<String> conditions = <String>[];

    if (nombre!.isNotEmpty) {
      conditions.add("nombre~'$nombre'");
    }
    if (codigo != null) {
      conditions.add("codigo=$codigo");
    }

    final String queryString = conditions.isNotEmpty ? conditions.join("&&") : conditions.join();
    final String data = queryString.isNotEmpty ? "($queryString)" : "";
    return data;
  }
}
