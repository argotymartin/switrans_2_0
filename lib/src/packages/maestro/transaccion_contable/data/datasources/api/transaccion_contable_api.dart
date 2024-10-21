import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/request/transaccion_contable_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/util/resources/entity_update.dart';

const String endPoint = "api/v1/erp/transacciones_contables";

class TransaccionContableApi {
  final Dio _dio;
  TransaccionContableApi(this._dio);

  Future<Response<dynamic>> getTransaccionContableApi(TransaccionContableRequest request) async {
    final TransaccionContableRequestModel requestModel = TransaccionContableRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint';
    final Response<dynamic> response = await _dio.get(url, queryParameters: requestModel.toJson());
    return response;
  }

  Future<Response<dynamic>> setTransaccionContableApi(TransaccionContableRequest request) async {
    final TransaccionContableRequestModel requestModel = TransaccionContableRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint/crear';
    final Response<dynamic> response = await _dio.post(url, data: requestModel.toJson());
    return response;
  }

  Future<Response<dynamic>> updateTransaccionContableApi(EntityUpdate<TransaccionContableRequest> request) async {
    final TransaccionContableRequestModel requestModel = TransaccionContableRequestModel.fromRequest(request.entity);

    final String url = '$kBackendBaseUrlERP/$endPoint/actualizar/${request.id}';
    final Response<dynamic> responseUpdate = await _dio.put(url, data: requestModel.toJson());
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final TransaccionContableRequest transaccionContableRequest = TransaccionContableRequest(codigo: request.id);
      response = await getTransaccionContableApi(transaccionContableRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getTipoImpuestosApi() async {
    final String url = '$kBackendBaseUrlERP/$endPoint/tipo_impuestos';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }
}
