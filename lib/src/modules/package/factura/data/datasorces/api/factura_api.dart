import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

const endPoint = "api/v1/erp/facturas";

class FacturaAPI {
  final Dio _dio;
  FacturaAPI(this._dio);

  Future<Response> getEmpresasApi() async {
    const url = '$kBackendBaseUrl/$endPoint/empresas';
    final response = await _dio.get(url);
    return response;
  }

  Future<Response> getClienteApi() async {
    const url = '$kBackendBaseUrl/$endPoint/clientes';
    final response = await _dio.get(url);
    return response;
  }

  Future<Response> getDocumentosApi(FacturaRequest request) async {
    const url = '$kBackendBaseUrl/$endPoint/remesas';
    final params = request.toJson();
    final response = await _dio.get(url, queryParameters: params);
    return response;
  }
}
