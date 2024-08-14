class TransaccionContableRequest {
  int? codigo;
  String? nombre;
  String? sigla;
  bool? isActivo;
  int? secuencia;
  int? tipoImpuesto;
  int? usuario;

  TransaccionContableRequest({
    this.codigo,
    this.nombre,
    this.sigla,
    this.isActivo,
    this.secuencia,
    this.tipoImpuesto,
    this.usuario,
  });

  bool hasNonNullField() {
    return codigo != null ||
        nombre != null ||
        sigla != null ||
        isActivo != null ||
        secuencia != null ||
        tipoImpuesto != null ||
        usuario != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    sigla = null;
    isActivo = null;
    tipoImpuesto = null;
    usuario = null;
    secuencia = null;
  }
}
