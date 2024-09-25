class PaisRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  int? codigoUsuario;
  String? fechaCreacion;

  PaisRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.codigoUsuario,
    this.fechaCreacion,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || isActivo != null || codigoUsuario != null || fechaCreacion != null;
  }

  void clean() {
    codigo ??= null;
    nombre ??= null;
    isActivo ??= null;
    codigoUsuario ??= null;
    fechaCreacion ??= null;
  }
}
