class ServicioEmpresarialRequest {
  int? codigo;
  String? nombre;
  int? usuario;
  bool? esActivo;

  ServicioEmpresarialRequest({
    this.codigo,
    this.nombre,
    this.usuario,
    this.esActivo,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || usuario != null || esActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    usuario = null;
    esActivo = null;
  }

}
