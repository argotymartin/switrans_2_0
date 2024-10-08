class MunicipioRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  String? fechaCreacion;
  int? codigoUsuario;
  String? usuarioNombre;
  int? departamento;

  MunicipioRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.fechaCreacion,
    this.codigoUsuario,
    this.usuarioNombre,
    this.departamento,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || departamento != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    fechaCreacion = null;
    codigoUsuario = null;
    usuarioNombre = null;
    departamento = null;
  }
}
