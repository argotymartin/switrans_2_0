import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';

class TipoDocumentoModel extends TipoDocumento {
  TipoDocumentoModel({
    required super.codigo,
    required super.nombre,
  });

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) => TipoDocumentoModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
      );
}
