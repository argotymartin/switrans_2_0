import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

const String endPoint = "api/v1/maestro/accion_documentos";

class AccionDocumentoApi {
  final Dio _dio;
  AccionDocumentoApi(this._dio);

  Future<Response<dynamic>> getAccionDocumentosApi(AccionDocumentoRequest request) async {
    final AccionDocumentoRequestModel requestModel = AccionDocumentoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setAccionDocumentoApi(AccionDocumentoRequest request) async {
    final AccionDocumentoRequestModel requestModel = AccionDocumentoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateAccionDocumentosApi(EntityUpdate<AccionDocumentoRequest> request) async {
    final AccionDocumentoRequestModel requestModel = AccionDocumentoRequestModel.fromRequest(request.entity);
    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.id}';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final AccionDocumentoRequest departamentoRequest = AccionDocumentoRequest(codigo: request.id);
      response = await getAccionDocumentosApi(departamentoRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getDocumentosApi() async {
    final String url = '$kBackendBaseUrlMaestro/$endPoint/documentos';
    final Response<dynamic> response = await _dio.get('$url');
    return response;
  }
}
