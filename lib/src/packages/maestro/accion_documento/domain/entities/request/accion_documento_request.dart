class AccionDocumentoRequest {
  int? codigo;
  String? nombre;
  bool? isActivo;
  bool? isInversa;
  bool? isReversible;
  String? fechaCreacion;
  int? codigoDocumento;
  String? nombreDocumento;
  int? codigoUsuario;
  String? nombreUsuario;

  AccionDocumentoRequest({
    this.nombre,
    this.codigo,
    this.isActivo,
    this.isInversa,
    this.isReversible,
    this.fechaCreacion,
    this.codigoDocumento,
    this.nombreDocumento,
    this.codigoUsuario,
    this.nombreUsuario,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || codigoDocumento != null || isActivo != null || isInversa != null  || isReversible != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    isActivo = null;
    isInversa = null;
    isReversible = null;
    fechaCreacion = null;
    codigoDocumento = null;
    nombreDocumento = null;
    codigoUsuario = null;
    nombreUsuario = null;
  }
}
