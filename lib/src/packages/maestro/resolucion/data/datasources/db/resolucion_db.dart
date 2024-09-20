import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/data/resolucion_data.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';

const String endPoint = "api/v1/erp/resoluciones";
const String endPointEmpresas = "/api/v1/maestro";

class ResolucionDB {
  final Dio _dio;
  ResolucionDB(this._dio);

  Future<Response<dynamic>> getDocumentosDB() async {
    const String url = 'http://192.168.24.158:8085/$endPoint/documentos/tipos';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getEmpresasDB() async {
    const String url = 'http://192.168.24.158:8084$endPointEmpresas/empresa';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getCentroCostoDB(ResolucionEmpresa request) async {
    const String url = 'http://192.168.24.158:8085/$endPoint/centrocostos';
    final Map<String, dynamic> params = <String, dynamic>{"codigoEmpresa": request.codigo};
    final Response<dynamic> response =
        await _dio.request(url, data: params, options: Options(contentType: 'application/json', method: 'GET'));
    return response;
  }

  Future<Response<dynamic>> getResolucionesDB(ResolucionRequest request) async {
    final ResolucionRequestModel requestModel = ResolucionRequestModel.fromRequest(request);
    const String url = 'http://192.168.24.158:8085/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.request(url,
        data: params, options: Options(headers: <String, dynamic>{'Content-Type': 'application/json'}, method: 'GET'),);
    return response;
  }

  Future<Response<dynamic>> setResolucionesDB(ResolucionRequest request) async {
    final ResolucionRequestModel requestModel = ResolucionRequestModel.fromRequest(request);
    const String url = 'http://192.168.24.158:8085/$endPoint/crear';
    final Map<String, dynamic> data = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: data, options: Options(contentType: 'application/json'));
    return response;
  }

  Future<Response<dynamic>> updateResolucionesDB(ResolucionRequest request) async {
    final ResolucionRequestModel requestModel = ResolucionRequestModel.fromRequest(request);
    final String url = 'http://192.168.24.158:8085/$endPoint/actualizar/${requestModel.codigo}';
    final Map<String, dynamic> data = requestModel.toJson();
    final Response<dynamic> response = await _dio.request(
      url,
      data: jsonEncode(data),
      options: Options(headers: <String, dynamic>{'Content-Type': 'application/json'}, method: 'PUT'),
    );

    if (response.statusCode == 204) {
      return await getResolucionesDB(request);
    }
    return response;
  }
}
