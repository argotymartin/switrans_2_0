import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
const String endPoint = "api/v1/maestro/municipios";


class MunicipioApi {
  final Dio _dio;
  MunicipioApi(this._dio);

  Future<Response<dynamic>> getMunicipiosApi(MunicipioRequest request) async {
    final MunicipioRequestModel requestModel = MunicipioRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setMunicipioApi(MunicipioRequest request) async {
    final MunicipioRequestModel requestModel = MunicipioRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateMunicipioApi(MunicipioRequest request) async {
    final MunicipioRequestModel requestModel = MunicipioRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.codigo}';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final MunicipioRequest municipioRequest = MunicipioRequest(codigo: request.codigo);
      response = await getMunicipiosApi(municipioRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getDepartamentosApi() async {
    final String url = '$kBackendBaseUrlMaestro/api/v1/maestro/departamentos';
    //final String url = '$kBackendBaseUrlMaestro/$endPoint/departamentos';
    final Map<String, dynamic> params = <String, dynamic>{'estado': true};
    final Response<String> response = await _dio.get('$url', queryParameters: params);
    return response;
  }
}
