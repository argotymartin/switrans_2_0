import 'package:dio/dio.dart';

import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/models/request/paquete_request_model_pb.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class PaqueteApiPocketBase {
  final Dio _dio;
  PaqueteApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaquetesApi(PaqueteRequest request) async {
    final PaqueteRequestModelPB requestModel = PaqueteRequestModelPB.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    final String filter = PaqueteRequestModelPB.toPocketBaseFilter(requestMap);

    final String url = '$kPocketBaseUrl/api/collections/paquete/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaqueteApi(PaqueteRequest request) async {
    final PaqueteRequestModelPB requestModel = PaqueteRequestModelPB.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    requestMap["codigo"] = await FunctionsPocketbase.getMaxCodigoCollection(dio: _dio, collection: "paquete", field: "codigo");

    final String url = '$kPocketBaseUrl/api/collections/paquete/records';
    final Response<String> response = await _dio.post('$url/', data: requestMap);
    return response;
  }

  Future<Response<dynamic>> updatePaqueteApi(EntityUpdate<PaqueteRequest> request) async {
    final PaqueteRequestModelPB requestModel = PaqueteRequestModelPB.fromRequestPB(request.entity);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();

    final String id = await FunctionsPocketbase.getIdCollection(
      dio: _dio,
      collection: "paquete",
      field: "codigo",
      value: request.id,
    );

    final String url = '$kPocketBaseUrl/api/collections/paquete/records/$id?';

    final Response<dynamic> response = await _dio.patch(url, data: requestMap);
    return response;
  }
}
