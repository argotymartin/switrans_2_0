class PreFactura {
  int documento;
  String documentoImpreso;
  String tipo;
  String descripcion;
  int valor;
  int cantidad;
  int total;
  PreFactura({
    required this.documentoImpreso,
    required this.documento,
    required this.tipo,
    required this.descripcion,
    required this.valor,
    required this.cantidad,
    required this.total,
  });
}
