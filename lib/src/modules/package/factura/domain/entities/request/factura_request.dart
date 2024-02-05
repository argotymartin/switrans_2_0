class FacturaRequest {
  final int empresa;
  final int cliente;
  final String remesas;
  final String inicio;
  final String fin;
  FacturaRequest({
    required this.empresa,
    required this.cliente,
    this.remesas = '',
    this.inicio = '',
    this.fin = '',
  });

  Map<String, dynamic> toJson() => {
        'empresa': empresa,
        'cliente': cliente,
        'remesas': remesas,
        'inicio': inicio,
        'fin': fin,
      };
}
