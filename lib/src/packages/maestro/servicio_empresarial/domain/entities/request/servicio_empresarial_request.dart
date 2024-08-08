class ServicioEmpresarialRequest {
  int? codigo;
  String? nombre;
  int? usuario;
  bool? isActivo;

  ServicioEmpresarialRequest({
    this.codigo,
    this.nombre,
    this.usuario,
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
