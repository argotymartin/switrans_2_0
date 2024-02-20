import 'package:switrans_2_0/src/modules/package/factura/data/models/documento_model.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/models/item_documento_model.dart';

class PrefacturaRequest {
  final int centroCosto;
  final int cliente;
  final int empresa;
  final int usuario;
  final int valorImpuesto;
  final int valorNeto;
  final List<DocumentoModel> documentos;
  final List<ItemDocumentoModel> items;

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

  Map<String, dynamic> toJson() => {
        "centroCosto": centroCosto,
        "cliente": cliente,
        "empresa": empresa,
        "usuario": usuario,
        "valorImpuesto": valorImpuesto,
        "valorNeto": valorNeto,
        "documentos": List<dynamic>.from(documentos.map((x) => x.toJson())),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
