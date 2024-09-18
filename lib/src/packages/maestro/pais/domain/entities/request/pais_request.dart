class PaisRequest {
  int? codigo;
  int? codigoUsuario;
  String? nombre;
  String? fechaCreacion;
  bool? isActivo;

  PaisRequest({
    this.codigo,
    this.codigoUsuario,
    this.nombre,
    this.fechaCreacion,
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
