import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class FormFacturaRequestModel extends FormFacturaRequest {
  FormFacturaRequestModel({
    super.cliente,
    super.documentoCodigo,
    super.documentos,
    super.empresa,
    super.rangoFechas,
  });

  factory FormFacturaRequestModel.fromRequest(FormFacturaRequest request) => FormFacturaRequestModel(
        cliente: request.cliente,
        documentoCodigo: request.documentoCodigo,
        documentos: request.documentos,
        empresa: request.empresa,
        rangoFechas: request.rangoFechas,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'empresa': empresa,
      'cliente': cliente,
      'documentoCodigo': documentoCodigo,
    };
    if (documentos != "") {
      final List<String> parts = documentos!.split(',').map((String e) => e.trim()).toList();
      final String documentosParse = parts.join(', ');
      data['documentos'] = documentosParse;
    }
    if (rangoFechas != null) {
      final List<String> listFechas = rangoFechas!.split(' - ');
      data['fechaInicio'] = listFechas[0].trim();
      data['fechaFin'] = listFechas[1].trim();
    }

    return data;
  }
}
