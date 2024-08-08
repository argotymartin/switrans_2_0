class TipoImpuestoRequest {
  int? codigo;
  int? usuario;
  String? nombre;
  bool? isActivo;


  TipoImpuestoRequest({
    this.nombre,
    this.usuario,
    this.codigo,
    this.isActivo,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || usuario != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    usuario = null;
    isActivo = null;
  }
}
