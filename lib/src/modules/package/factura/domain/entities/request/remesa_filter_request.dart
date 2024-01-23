class RemesaFilterRequest {
  final List<int> empresas;
  final int cliente;
  final String remesas;
  final String inicio;
  final String fin;
  RemesaFilterRequest({
    required this.empresas,
    required this.cliente,
    required this.remesas,
    required this.inicio,
    required this.fin,
  });
}
