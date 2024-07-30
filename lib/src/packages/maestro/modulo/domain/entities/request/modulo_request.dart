class ModuloRequest {
  int? codigo;
  String? nombre;
  String? detalle;
  String? path;
  bool? isVisible;
  String? icono;
  int? paquete;
  bool? isActivo;

  ModuloRequest({
    this.codigo,
    this.nombre,
    this.detalle,
    this.path,
    this.isVisible,
    this.icono,
    this.paquete,
    this.isActivo,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || detalle != null || path != null || isVisible != null || icono != null || paquete != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    detalle = null;
    isVisible = null;
    path = null;
    isActivo = null;
  }
}
