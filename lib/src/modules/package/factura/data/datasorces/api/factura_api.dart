import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
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
    //const url = '$kPocketBaseUrl/api/collections/remesa/records';
    const url = '$kBackendBaseUrl/api/v1/erp/facturas/remesas';
    //String jsonRequest = jsonEncode(request.toJson());
    var data = {"empresa": 1, "cliente": 1409, "remesas": "01035-3378,01035-3379,01035-3380,01039-3069"};
    final response = await _dio.get(url, queryParameters: data);
    //final response = await _dio.get('$url/');
    return response;
  }
}
