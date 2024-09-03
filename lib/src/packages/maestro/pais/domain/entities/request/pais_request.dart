class PaisRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;

  PaisRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
  }
}
