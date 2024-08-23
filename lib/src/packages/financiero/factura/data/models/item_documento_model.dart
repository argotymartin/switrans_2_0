import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class ItemDocumentoModel extends ItemDocumento {
  ItemDocumentoModel({
    required super.documentoImpreso,
    required super.documento,
    required super.tipo,
    required super.descripcion,
    required super.valor,
    required super.cantidad,
    required super.total,
    super.porcentajeIva = 0,
    super.valorIva = 0,
  });

  factory ItemDocumentoModel.toDocumetnoTR(Documento documento) => ItemDocumentoModel(
        cantidad: 1,
        documentoImpreso: documento.impreso,
        descripcion: documento.descripcion,
        documento: documento.documento,
        valor: documento.valorEgreso,
        tipo: "TR",
        total: documento.valorTotal,
      );

  factory ItemDocumentoModel.init() => ItemDocumentoModel(
        cantidad: 1,
        documentoImpreso: "",
        descripcion: "",
        documento: 0,
        tipo: "",
        total: 0,
        valor: 0,
        porcentajeIva: 19,
      );
}
