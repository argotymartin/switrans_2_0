class DepartamentoRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  String? codigoDane;
  String? fechaCreacion;
  int? codigoUsuario;
  String? nombrePais;
  int? codigoPais;

  DepartamentoRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.codigoDane,
    this.fechaCreacion,
    this.codigoUsuario,
    this.nombrePais,
    this.codigoPais,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || codigoPais != null || isActivo != null || codigoDane != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    codigoDane = null;
    fechaCreacion = null;
    codigoUsuario = null;
    nombrePais = null;
    codigoPais = null;
  }
}
