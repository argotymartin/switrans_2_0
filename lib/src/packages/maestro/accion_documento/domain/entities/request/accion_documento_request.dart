class AccionDocumentoRequest {
  final int? codigo;
  final String? nombre;
  final int? tipo;
  final int? usuario;
  final bool isInverso;
  final String? fechaInicio;
  final String? fechaFin;

  AccionDocumentoRequest({
    this.nombre,
    this.codigo,
    this.tipo,
    this.usuario,
    this.isInverso = false,
    this.fechaInicio,
    this.fechaFin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nombre': nombre,
    };
    if (codigo != 0) data['codigo'] = codigo;

    return data;
  }
}
