import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class FacturaAPI {
  final Dio _dio;

  FacturaAPI(this._dio);

  Future<Response> getEmpresasApi() async {
    const url = '$kBackendBaseUrl/api/v1/erp/prefactura/empresa';
    final response = await _dio.get(url);
    return response;
  }

  Future<Response> getClienteApi() async {
    const url = '$kPocketBaseUrl/api/collections/cliente/records';
    final response = await _dio.get('$url/');
    return response;
  }

  Future<Response> getRemesaApi() async {
    const url = '$kPocketBaseUrl/api/collections/remesa/records';
    final response = await _dio.get('$url/');
    return response;
  }
}
