class PaisRequest {
  int? codigo;
  int? codigoUsuario;
  String? nombre;
  String? fechaCreacion;
  bool? estado;

  PaisRequest({
    this.codigo,
    this.codigoUsuario,
    this.nombre,
    this.fechaCreacion,
    this.estado,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || estado != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    estado = null;
  }
}
