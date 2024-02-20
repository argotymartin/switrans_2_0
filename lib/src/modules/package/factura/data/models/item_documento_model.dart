import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';

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
        descripcion: documento.observacionFactura.isNotEmpty ? documento.observacionFactura : documento.observacion,
        documento: documento.remesa,
        valor: documento.flete,
        tipo: "TR",
        total: 0,
      );

  factory ItemDocumentoModel.init() => ItemDocumentoModel(
        cantidad: 1,
        documentoImpreso: "",
        descripcion: "",
        documento: 0,
        tipo: "",
        total: 0,
        valor: 0,
        valorIva: 0,
        porcentajeIva: 19,
      );
}
