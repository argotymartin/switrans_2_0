class FormularioFilterRequest {
  final int empresa;
  final int cliente;
  final String remesas;
  final String inicio;
  final String fin;
  FormularioFilterRequest({
    required this.empresa,
    required this.cliente,
    required this.remesas,
    required this.inicio,
    required this.fin,
  });
}
