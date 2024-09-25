import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_impuesto.dart';

class DocumentoRequest {
  final int documento;
  final int codigoServicio;
  final int tipoItemFactura;
  final String servicioNombre;
  final String descripcion;
  final double subtotal;
  final int total;
  final List<ItemImpuesto> impuestos;

  DocumentoRequest({
    required this.documento,
    required this.codigoServicio,
    required this.tipoItemFactura,
    required this.servicioNombre,
    required this.descripcion,
    required this.subtotal,
    required this.total,
    required this.impuestos,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "documento": documento,
        "codigoServicio": codigoServicio,
        "tipoItemFactura": tipoItemFactura,
        "servicioNombre": servicioNombre,
        "descripcion": descripcion,
        "subtotal": subtotal,
        "total": total,
        "impuestos": impuestos,
      };
}
