class UnidadNegocioRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  int? usuario;
  int? empresa;

  UnidadNegocioRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.usuario,
    this.empresa,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || isActivo != null || usuario != null || empresa != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    usuario = null;
    empresa = null;
  }
}
