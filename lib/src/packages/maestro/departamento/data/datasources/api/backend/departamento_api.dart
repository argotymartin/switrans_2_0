import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/models/request/departamento_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/request/departamento_request.dart';

const String endPoint = "api/v1/maestro/departamentos";
const String endPoint1 = "api/v1/maestro/paises";

class DepartamentoApi {
  final Dio _dio;
  DepartamentoApi(this._dio);

  Future<Response<dynamic>> getDepartamentosApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequestAPI(request);
    final String url = '$kBackendBaseUrl/$endPoint';
    final Map<String, dynamic> params = requestModel.toJsonConsultarAPI();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setDepartamentoApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequestAPI(request);
    final String url = '$kBackendBaseUrl/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJsonCrearAPI();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateDepartamentoApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequestAPI(request);
    final String url = '$kBackendBaseUrl/$endPoint/actualizar/${request.codigo}';
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
    const String url = 'http://192.168.24.163:8084/api/v1/maestro/paises';
    final Map<String, dynamic> params = <String, dynamic>{"filter": "(activo = true)"};
    final Response<String> response = await _dio.get('$url', data: params);
    return response;
  }
}
