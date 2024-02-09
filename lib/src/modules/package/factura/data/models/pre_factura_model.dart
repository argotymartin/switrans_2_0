import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';

class PreFacturaModel extends PreFactura {
  PreFacturaModel({
    required super.documentoImpreso,
    required super.documento,
    required super.tipo,
    required super.descripcion,
    required super.valor,
    required super.cantidad,
    required super.total,
  });

  factory PreFacturaModel.toDocumetno(Documento documento) => PreFacturaModel(
        cantidad: 4,
        documentoImpreso: documento.impreso,
        descripcion: documento.observacion,
        documento: documento.remesa,
        tipo: "",
        total: documento.total,
        valor: documento.flete,
      );

  factory PreFacturaModel.init() => PreFacturaModel(
        cantidad: 4,
        documentoImpreso: "",
        descripcion: "",
        documento: 0,
        tipo: "",
        total: 1,
        valor: 0,
      );
}
