import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

const String endPoint = "api/v1/erp/facturas";

class FacturaAPI {
  final Dio _dio;
  FacturaAPI(this._dio);

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

  Future<Response<dynamic>> getDocumentosApi(FacturaRequest request) async {
    const String url = '$kBackendBaseUrl/$endPoint/remesas';
    final Map<String, dynamic> params = request.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }
}
