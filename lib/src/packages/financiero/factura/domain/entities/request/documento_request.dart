class DocumentoRequest {
  int? documento;
  int? codigoServicio;
  int? tipoItemFactura;
  String? servicioNombre;
  String? descripcion;
  double? subtotal;
  double? total;
  Map<String, dynamic>? impuesto;

  DocumentoRequest({
    this.documento,
    this.codigoServicio,
    this.tipoItemFactura,
    this.servicioNombre,
    this.descripcion,
    this.subtotal,
    this.total,
    this.impuesto,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "documento": documento,
        "codigoServicio": codigoServicio,
        "tipoItemFactura": tipoItemFactura,
        "servicioNombre": servicioNombre,
        "descripcion": descripcion,
        "subtotal": subtotal,
        "total": total,
        "impuesto": impuesto,
      };
}
