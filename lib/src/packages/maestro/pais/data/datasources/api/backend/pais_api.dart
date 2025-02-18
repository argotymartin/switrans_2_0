import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

const String endPoint = "api/v1/maestro/paises";

class PaisApi {
  final Dio _dio;
  PaisApi(this._dio);

  Future<Response<dynamic>> getPaisesApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setPaisApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updatePaisApi(EntityUpdate<PaisRequest> request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequest(request.entity);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.id}';
    final Response<dynamic> responseUpdate = await _dio.put(url, data: requestModel.toJson());
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final PaisRequest paisRequest = PaisRequest(codigo: request.id);
      response = await getPaisesApi(paisRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }
}
