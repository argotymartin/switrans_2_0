import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';

class FacturaRequest {
  final int tipoDocumento;
  final int cliente;
  final int empresa;
  final int centroCosto;
  final int usuario;
  final double subtotal;
  final double total;
  final Map<String, dynamic> impuestos;
  final List<Documento> items;

  FacturaRequest({
    required this.tipoDocumento,
    required this.cliente,
    required this.empresa,
    required this.centroCosto,
    required this.usuario,
    required this.subtotal,
    required this.total,
    required this.impuestos,
    required this.items,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "tipoDocumento": tipoDocumento,
        "cliente": cliente,
        "empresa": empresa,
        "centroCosto": centroCosto,
        "usuario": usuario,
        "subtotal": subtotal,
        "total": total,
        "impuestos": impuestos,
        "items": List<dynamic>.from(items.map((Documento x) => x.toJson())),
      };
}
