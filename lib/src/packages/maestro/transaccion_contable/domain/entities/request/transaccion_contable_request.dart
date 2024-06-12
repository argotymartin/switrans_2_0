class TransaccionContableRequest {
  int? codigo;
  String? nombre;
  String? sigla;
  bool? isActivo;
  String? tipoImpuesto;
  int? usuario;
  int? secuencia;

  TransaccionContableRequest({
    this.codigo,
    this.nombre,
    this.sigla,
    this.isActivo,
    this.tipoImpuesto,
    this.usuario,
    this.secuencia,});
}
