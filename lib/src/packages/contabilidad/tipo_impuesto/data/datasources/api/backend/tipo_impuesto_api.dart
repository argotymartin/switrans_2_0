import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/data/data.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

const String endPoint = "api/v1/erp/tipo_impuestos";

class TipoImpuestoApi {
  final Dio _dio;
  TipoImpuestoApi(this._dio);

  Future<Response<dynamic>> getTipoImpuestosApi(TipoImpuestoRequest request) async {
    final TipoImpuestoRequestModel requestModel = TipoImpuestoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint';
    final Map<String, dynamic> params = requestModel.toJson();

    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }

  Future<Response<dynamic>> setTipoImpuestoApi(TipoImpuestoRequest request) async {
    final TipoImpuestoRequestModel requestModel = TipoImpuestoRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateTipoImpuestosApi(EntityUpdate<TipoImpuestoRequest> request) async {
    final TipoImpuestoRequestModel requestModel = TipoImpuestoRequestModel.fromRequest(request.entity);
    final String url = '$kBackendBaseUrlERP/$endPoint/actualizar/${request.id}';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final TipoImpuestoRequest tipoImpuestoRequest = TipoImpuestoRequest(codigo: request.id);
      response = await getTipoImpuestosApi(tipoImpuestoRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }
}
