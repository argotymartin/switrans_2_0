class FormFacturaRequest {
  int? empresa;
  int? cliente;
  int? documentoCodigo;
  int? centroCostoCodigo;
  String? documentos;
  String? rangoFechas;
  FormFacturaRequest({
    this.empresa,
    this.cliente,
    this.centroCostoCodigo,
    this.documentoCodigo,
    this.documentos,
    this.rangoFechas,
  });

  void clean() {
    empresa = null;
    cliente = null;
    documentoCodigo = null;
    centroCostoCodigo = null;
    documentos = null;
    rangoFechas = null;
  }
}
