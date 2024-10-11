import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

const String endPoint = "api/v1/maestro/departamentos";

class DepartamentoApi {
  final Dio _dio;
  DepartamentoApi(this._dio);

  Future<Response<dynamic>> getDepartamentosApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();

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

  Future<Response<dynamic>> updateDepartamentoApi(EntityUpdate<DepartamentoRequest> request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequest(request.entity);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.id}';

    final Response<dynamic> responseUpdate = await _dio.put(url, data: requestModel.toJson());
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final DepartamentoRequest departamentoRequest = DepartamentoRequest(codigo: request.id);
      response = await getDepartamentosApi(departamentoRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getPaisesApi() async {
    final String url = '$kBackendBaseUrlMaestro/api/v1/maestro/paises';
    final Response<String> response = await _dio.get('$url');
    return response;
  }
}
