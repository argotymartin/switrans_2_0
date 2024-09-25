import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/request/documento_request.dart';

class DocumentoRequestModel extends DocumentoRequest {
  DocumentoRequestModel({
    required super.documento,
    required super.codigoServicio,
    required super.tipoItemFactura,
    required super.servicioNombre,
    required super.descripcion,
    required super.subtotal,
    required super.total,
    required super.impuestos,
  });

  factory DocumentoRequestModel.formJson(Map<String, dynamic> json) => DocumentoRequestModel(
        documento: json["documento"],
        codigoServicio: json["codigoServicio"],
        tipoItemFactura: json["tipoItemFactura"],
        servicioNombre: json["servicioNombre"],
        descripcion: json["descripcion"],
        subtotal: json["subtotal"],
        total: json["total"],
        impuestos: json["impuestos"],
      );
}
