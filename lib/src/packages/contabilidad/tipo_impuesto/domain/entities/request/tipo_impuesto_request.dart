class TipoImpuestoRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  String? fechaCreacion;
  int? codigoUsuario;
  String? nombreUsuario;

  TipoImpuestoRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.fechaCreacion,
    this.codigoUsuario,
    this.nombreUsuario,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    fechaCreacion = null;
    codigoUsuario = null;
    nombreUsuario = null;
  }
}
