import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/request/documento_request.dart';

class FacturaRequest {
  final int tipoDocumento;
  final int codigoEmpresa;
  final int codigoCentroCosto;
  final int codigoCliente;
  final int codigoUsuario;

  final double subtotal;
  final double total;
  final List<DocumentoRequest> items;

  FacturaRequest({
    required this.tipoDocumento,
    required this.codigoEmpresa,
    required this.codigoCentroCosto,
    required this.codigoCliente,
    required this.codigoUsuario,
    required this.subtotal,
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "tipoDocumento": tipoDocumento,
        "codigoEmpresa": codigoEmpresa,
        "codigoCentroCosto": codigoCentroCosto,
        "codigoCliente": codigoCliente,
        "codigoUsuario": codigoUsuario,
        "subtotal": subtotal,
        "total": total,
        "items": List<dynamic>.from(items.map((DocumentoRequest x) => x.toJson())),
      };
}
