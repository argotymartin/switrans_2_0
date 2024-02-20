class ItemDocumento {
  int documento;
  String documentoImpreso;
  String tipo;
  String descripcion;
  double valor;
  int cantidad;
  double total;
  int porcentajeIva;
  double valorIva;
  ItemDocumento({
    required this.documentoImpreso,
    required this.documento,
    required this.tipo,
    required this.descripcion,
    required this.valor,
    required this.cantidad,
    required this.total,
    required this.porcentajeIva,
    required this.valorIva,
  });
}
