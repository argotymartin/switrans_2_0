class PaginaRequest {
  int? codigo;
  String? nombre;
  String? path;
  int? modulo;
  bool? isVisible;
  bool? isActivo;

  PaginaRequest({
    this.codigo,
    this.nombre,
    this.path,
    this.modulo,
    this.isVisible,
    this.isActivo,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || path != null || modulo != null || isVisible != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    path = null;
    modulo = null;
    isVisible = null;
    isActivo = null;
  }
}
