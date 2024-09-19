class DepartamentoRequest {
  int? codigo;
  int? codigoUsuario;
  String? codigoDane;
  String? nombre;
  int? pais;
  String? fechaCreacion;
  bool? isActivo;

  DepartamentoRequest({
    this.codigo,
    this.codigoUsuario,
    this.codigoDane,
    this.nombre,
    this.pais,
    this.fechaCreacion,
    this.isActivo,
  });

  bool hasNonNullField() {
    return codigo != null ||
        codigoUsuario != null ||
        codigoDane != null ||
        nombre != null ||
        pais != null ||
        fechaCreacion != null ||
        isActivo != null;
  }

  void clean() {
    codigo = null;
    codigoUsuario = null;
    codigoDane = null;
    nombre = null;
    pais = null;
    fechaCreacion = null;
    isActivo = null;
  }
}
