import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

const String endPoint = "api/v1/erp/resoluciones";
const String endPointEmpresas = "/api/v1/maestro";

class ResolucionApi {
  final Dio _dio;
  ResolucionApi(this._dio);

  Future<Response<dynamic>> getResolucionesApi(ResolucionRequest request) async {
    final ResolucionRequestModel requestModel = ResolucionRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.get(url, data: params);
    return response;
  }

  Future<Response<dynamic>> setResolucionesApi(ResolucionRequest request) async {
    final ResolucionRequestModel requestModel = ResolucionRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint/crear';
    final Map<String, dynamic> data = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: data);
    return response;
  }

  Future<Response<dynamic>> updateResolucionesApi(EntityUpdate<ResolucionRequest> request) async {
    final ResolucionRequestModel requestModel = ResolucionRequestModel.fromRequest(request.entity);
    final String url = '$kBackendBaseUrlERP/$endPoint/actualizar/${requestModel.codigo}';
    final Map<String, dynamic> data = requestModel.toJson();
    final Response<dynamic> response = await _dio.put(url, data: data);

    if (response.statusCode == 204) {
      return await getResolucionesApi(request.entity);
    }
    return response;
  }

  Future<Response<dynamic>> getDocumentosApi() async {
    final String url = '$kBackendBaseUrlERP/$endPoint/documentos/tipos';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getEmpresasApi() async {
    final String url = '$kBackendBaseUrlMaestro/$endPointEmpresas/empresa';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getCentroCostoApi(ResolucionEmpresa request) async {
    final String url = '$kBackendBaseUrlERP/$endPoint/centrocostos';
    final Map<String, dynamic> params = <String, dynamic>{"codigoEmpresa": request.codigo};
    final Response<dynamic> response = await _dio.get(url, data: params);
    return response;
  }
}
