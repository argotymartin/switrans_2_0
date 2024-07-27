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

  factory AccionDocumentoRequest.fromMap(Map<String, dynamic> map) => AccionDocumentoRequest(
        nombre: map['nombre'],
        codigo: map['codigo'],
        tipoDocumento: map['tipo_documento'],
        isNaturalezaInversa: map['naturaleza_inversa'],
        isActivo: map['activo'],
      );

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
