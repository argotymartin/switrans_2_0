class UnidadNegocioRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  String? fechaCreacion;
  int? codigoUsuario;
  String? nombreUsuario;
  int? codigoEmpresa;

  UnidadNegocioRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.fechaCreacion,
    this.codigoUsuario,
    this.nombreUsuario,
    this.codigoEmpresa,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || isActivo != null || codigoEmpresa != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    fechaCreacion = null;
    codigoUsuario = null;
    nombreUsuario = null;
    codigoEmpresa = null;
  }
}
