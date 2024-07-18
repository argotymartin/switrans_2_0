class FormFacturaRequest {
  final int empresa;
  final int cliente;
  final String? remesas;
  final String? inicio;
  final String? fin;
  FormFacturaRequest({
    required this.empresa,
    required this.cliente,
    this.remesas,
    this.inicio,
    this.fin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'empresa': empresa,
      'cliente': cliente,
    };
    if (remesas != "") {
      data['remesas'] = remesas;
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
