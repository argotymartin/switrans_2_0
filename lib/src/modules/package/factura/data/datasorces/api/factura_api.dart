import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factura_entities.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class FacturaAPI {
  final Dio _dio;

  FacturaAPI(this._dio);

  Future<Response> getEmpresasApi() async {
    const url = '$kBackendBaseUrl/api/v1/erp/facturas/empresas';
    final response = await _dio.get(url);
    return response;
  }

  Future<Response> getClienteApi() async {
    //const url = '$kPocketBaseUrl/api/collections/cliente/records';
    const url = '$kBackendBaseUrl/api/v1/erp/facturas/clientes';
    final response = await _dio.get(url);
    return response;
  }

  Future<Response> getDocumentosApi(FacturaRequest request) async {
    const url = '$kBackendBaseUrl/api/v1/erp/facturas/remesas';
    final response = await _dio.get(url, queryParameters: request.toJson());
    return response;
  }
}
