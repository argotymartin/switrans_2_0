import 'package:dio/dio.dart';

import 'package:switrans_2_0/src/config/constans/constants.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

const String endPoint = "api/v1/erp/facturas";

class FacturaAPI {
  final Dio _dio;
  FacturaAPI(this._dio);

  Future<Response<dynamic>> getTipoDocumentoApi() async {
    final Response<dynamic> response = await getData();
    return response;
  }

  Future<Response<dynamic>> getEmpresasApi() async {
    const String url = '$kBackendBaseUrl/$endPoint/empresas';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getClienteApi() async {
    const String url = '$kBackendBaseUrl/$endPoint/clientes';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getDocumentosApi(FormFacturaRequest request) async {
    const String url = '$kBackendBaseUrl/$endPoint/documentos';
    final Map<String, dynamic> params = request.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> getData() async {
    final List<Map<String, dynamic>> data = <Map<String, dynamic>>[
      <String, dynamic>{"codigo": 1, "nombre": "Remesa"},
      <String, dynamic>{"codigo": 2, "nombre": "Cumplido"},
    ];
    final Response<dynamic> response = Response<dynamic>(
      requestOptions: RequestOptions(),
      data: data,
      statusCode: 200,
    );
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return response;
  }
}
