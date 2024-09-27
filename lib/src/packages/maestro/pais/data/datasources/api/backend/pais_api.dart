import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/models/request/pais_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';

const String endPoint = "api/v1/maestro/paises";

class PaisApi {
  final Dio _dio;
  PaisApi(this._dio);

  Future<Response<dynamic>> getPaisesApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrl/$endPoint';
    final Map<String, dynamic> params = requestModel.toJsonGet();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setPaisApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrl/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updatePaisApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrl/$endPoint/actualizar/${request.codigo}';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final PaisRequest paisRequest = PaisRequest(codigo: request.codigo);
      response = await getPaisesApi(paisRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }
}
