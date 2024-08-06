class TipoImpuestoRequest {
  int? codigo;
  int? usuario;
  String? nombre;
  String? fechaInicio;
  String? fechaFin;

  TipoImpuestoRequest({
    this.nombre,
    this.usuario,
    this.codigo,
    this.fechaInicio,
    this.fechaFin,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || usuario != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    usuario = null;
  }
}
