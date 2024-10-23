class TransaccionContableRequest {
  int? codigo;
  String? nombre;
  String? sigla;
  int? orden;
  bool? isActivo;
  String? fechaCreacion;
  int? codigoUsuario;
  String? nombreUsuario;
  int? codigoTipoImpuesto;
  String? nombreTipoImpuesto;
  bool? estadoTipoImpuesto;
  int? tipoImpuesto;

  TransaccionContableRequest({
    this.codigo,
    this.nombre,
    this.sigla,
    this.orden,
    this.isActivo,
    this.fechaCreacion,
    this.codigoUsuario,
    this.nombreUsuario,
    this.codigoTipoImpuesto,
    this.nombreTipoImpuesto,
    this.estadoTipoImpuesto,
    this.tipoImpuesto,
  });

  bool hasNonNullField() {
    return codigo != null || nombre != null || sigla != null || isActivo != null || orden != null || tipoImpuesto != null;
  }

  void clean() {
    codigo = null;
    nombre = null;
    sigla = null;
    orden = null;
    isActivo = null;
    fechaCreacion = null;
    codigoUsuario = null;
    nombreUsuario = null;
    codigoTipoImpuesto = null;
    nombreTipoImpuesto = null;
    estadoTipoImpuesto = null;
    tipoImpuesto = null;
  }
}
