import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

const String endPoint = "api/v1/maestro/unidad_negocios";

class UnidadNegocioApi {
  final Dio _dio;
  UnidadNegocioApi(this._dio);

  Future<Response<dynamic>> getUnidadNegociosApi(UnidadNegocioRequest request) async {
    final UnidadNegocioRequestModel requestModel = UnidadNegocioRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setUnidadNegociosApi(UnidadNegocioRequest request) async {
    final UnidadNegocioRequestModel requestModel = UnidadNegocioRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateUnidadNegociosApi(EntityUpdate<UnidadNegocioRequest> request) async {
    final UnidadNegocioRequestModel requestModel = UnidadNegocioRequestModel.fromRequest(request.entity);

    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.id}';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final UnidadNegocioRequest unidadNegocioRequest = UnidadNegocioRequest(codigo: request.id);
      response = await getUnidadNegociosApi(unidadNegocioRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getEmpresasApi() async {
    final String url = '$kBackendBaseUrlMaestro/$endPoint/empresas';
    final Response<dynamic> response = await _dio.get('$url');
    return response;
  }
}
