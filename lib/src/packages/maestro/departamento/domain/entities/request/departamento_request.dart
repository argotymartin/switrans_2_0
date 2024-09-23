class DepartamentoRequest {
  int? codigo;
  int? codigoUsuario;
  String? codigoDane;
  String? nombre;
  int? pais;
  String? fechaCreacion;
  bool? estado;

  DepartamentoRequest({
    this.codigo,
    this.codigoUsuario,
    this.codigoDane,
    this.nombre,
    this.pais,
    this.fechaCreacion,
    this.estado,
  });

  bool hasNonNullField() {
    return codigo != null ||
        codigoUsuario != null ||
        codigoDane != null ||
        nombre != null ||
        pais != null ||
        fechaCreacion != null ||
        estado != null;
  }

  void clean() {
    codigo = null;
    codigoUsuario = null;
    codigoDane = null;
    nombre = null;
    pais = null;
    fechaCreacion = null;
    estado = null;
  }
}
