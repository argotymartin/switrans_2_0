class PaisRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  int? codigoUsuario;
  String? usuarioNombre;
  String? fechaCreacion;

  PaisRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.codigoUsuario,
    this.usuarioNombre,
    this.fechaCreacion,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    codigoUsuario = null;
    usuarioNombre = null;
    fechaCreacion = null;
  }
}
