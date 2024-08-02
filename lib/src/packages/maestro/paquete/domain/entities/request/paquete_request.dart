class PaqueteRequest {
  int? codigo;
  String? nombre;
  String? path;
  bool? isVisible;
  bool? isActivo;
  String? icono;

  PaqueteRequest({
    this.codigo,
    this.nombre,
    this.path,
    this.isVisible,
    this.isActivo,
    this.icono,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || path != null || isVisible != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    path = null;
    isVisible = null;
    isActivo = null;
  }
}
