import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/item_documento.dart';

class PrefacturaRequest {
  final int centroCosto;
  final int cliente;
  final int empresa;
  final int usuario;
  final int valorImpuesto;
  final int valorNeto;
  final List<Documento> documentos;
  final List<ItemDocumento> items;

  PrefacturaRequest({
    required this.centroCosto,
    required this.cliente,
    required this.empresa,
    required this.usuario,
    required this.valorImpuesto,
    required this.valorNeto,
    required this.documentos,
    required this.items,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "centroCosto": centroCosto,
        "cliente": cliente,
        "empresa": empresa,
        "usuario": usuario,
        "valorImpuesto": valorImpuesto,
        "valorNeto": valorNeto,
        "documentos": List<dynamic>.from(documentos.map((Documento x) => x.toJson())),
        "items": List<dynamic>.from(items.map((ItemDocumento x) => x.toJson())),
      };
}
