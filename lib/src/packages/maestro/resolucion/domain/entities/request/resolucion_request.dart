class ResolucionRequest {
  int? codigo;
  String? numero;
  String? fecha;
  int? rangoInicial;
  int? rangoFinal;
  String? fechaVigencia;
  String? empresaPrefijo;
  String? version;
  bool? isActiva;
  int? codigoDocumento;
  int? codigoEmpresa;
  int? codigoUsuario;
  int? codigoCentroCosto;

  ResolucionRequest({
    this.codigo,
    this.numero,
    this.fecha,
    this.rangoInicial,
    this.rangoFinal,
    this.fechaVigencia,
    this.empresaPrefijo,
    this.version,
    this.isActiva,
    this.codigoDocumento,
    this.codigoEmpresa,
    this.codigoUsuario,
    this.codigoCentroCosto,
  });

  bool hasNonNullField() {
    return codigo != null ||
        numero != null ||
        fecha != null ||
        rangoInicial != null ||
        rangoFinal != null ||
        fechaVigencia != null ||
        empresaPrefijo != null ||
        version != null ||
        isActiva != null ||
        codigoDocumento != null ||
        codigoEmpresa != null ||
        codigoUsuario != null ||
        codigoCentroCosto != null;
  }

  void clean() {
    codigo = null;
    numero = null;
    fecha = null;
    rangoInicial = null;
    rangoFinal = null;
    fechaVigencia = null;
    empresaPrefijo = null;
    version = null;
    codigoDocumento = null;
    codigoEmpresa = null;
    codigoUsuario = null;
    codigoCentroCosto = null;
  }
}
