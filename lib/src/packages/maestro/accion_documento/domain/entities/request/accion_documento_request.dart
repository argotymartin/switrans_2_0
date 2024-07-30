class AccionDocumentoRequest {
  int? codigo;
  String? nombre;
  int? tipoDocumento;
  int? usuario;
  bool? isNaturalezaInversa;
  bool? isActivo;

  AccionDocumentoRequest({
    this.nombre,
    this.codigo,
    this.tipoDocumento,
    this.usuario,
    this.isNaturalezaInversa,
    this.isActivo,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || tipoDocumento != null || usuario != null || isNaturalezaInversa != null || isActivo != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    tipoDocumento = null;
    usuario = null;
    isNaturalezaInversa = null;
    isActivo = null;
  }
}
