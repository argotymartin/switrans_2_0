
class MunicipioRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  String? codigoDane;
  String? fechaCreacion;
  double? latitud;
  double? longitud;
  int? codigoUsuario;
  String? nombreUsuario;
  int? codigoDepartamento;
  int? codigoPais;

  MunicipioRequest({
    this.codigo,
    this.nombre,
    this.isActivo,
    this.codigoDane,
    this.fechaCreacion,
    this.codigoUsuario,
    this.nombreUsuario,
    this.codigoDepartamento,
    this.codigoPais,
    this.latitud,
    this.longitud,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || codigoDepartamento != null || codigoPais != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    codigoDane = null;
    fechaCreacion = null;
    latitud = null;
    longitud = null;
    codigoUsuario = null;
    nombreUsuario = null;
    codigoDepartamento = null;
    codigoPais = null;
  }
}
