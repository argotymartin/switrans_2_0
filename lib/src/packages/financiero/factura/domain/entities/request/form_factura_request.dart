class FormFacturaRequest {
  int? empresa;
  int? cliente;
  int? documentoCodigo;
  String? documentos;
  String? inicio;
  String? fin;
  FormFacturaRequest({
    this.empresa,
    this.cliente,
    this.documentoCodigo,
    this.documentos,
    this.inicio,
    this.fin,
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
    if (inicio != "") {
      data['inicio'] = inicio;
    }
    if (fin != "") {
      data['fin'] = fin;
    }

    return data;
  }
}
