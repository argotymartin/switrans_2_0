import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';

const String endPoint = "api/v1/maestro/departamentos";

class DepartamentoApi {
  final Dio _dio;
  DepartamentoApi(this._dio);

  Future<Response<dynamic>> getDepartamentosApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Map<String, dynamic> params = requestModel.toJsonGet();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setDepartamentoApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateDepartamentoApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.codigo}';
    final Map<String, dynamic> params = requestModel.toJsonUpdateAPI();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final DepartamentoRequest departamentoRequest = DepartamentoRequest(codigo: request.codigo);
      response = await getDepartamentosApi(departamentoRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getPaisesApi() async {
    final String url = '$kBackendBaseUrlMaestro/api/v1/maestro/paises';
    final Map<String, dynamic> params = <String, dynamic>{"filter": "(activo = true)"};
    final Response<String> response = await _dio.get('$url', data: params);
    return response;
  }
}
