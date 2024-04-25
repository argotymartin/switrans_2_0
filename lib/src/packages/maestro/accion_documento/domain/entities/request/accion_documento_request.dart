class AccionDocumentoRequest {
  final int? codigo;
  final String? nombre;
  final int? tipoDocumento;
  final int? usuario;
  final bool? isNaturalezaInversa;
  final bool? isActivo;

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
        //tipoDocumento: map['tipo_documento'],
        isNaturalezaInversa: map['naturaleza_inversa'],
        isActivo: map['activo'],
      );
}
