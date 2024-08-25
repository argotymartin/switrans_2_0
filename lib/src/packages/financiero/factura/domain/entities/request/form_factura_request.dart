class FormFacturaRequest {
  int? empresa;
  int? cliente;
  int? documentoCodigo;
  String? documentos;
  String? rangoFechas;
  FormFacturaRequest({
    this.empresa,
    this.cliente,
    this.documentoCodigo,
    this.documentos,
    this.rangoFechas,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'empresa': empresa,
      'cliente': cliente,
      'documentoCodigo': documentoCodigo,
    };
    if (documentos != "") {
      data['documentos'] = documentos;
    }
    if (rangoFechas != "") {
      data['rangoFechas'] = rangoFechas;
    }

    return data;
  }
}
