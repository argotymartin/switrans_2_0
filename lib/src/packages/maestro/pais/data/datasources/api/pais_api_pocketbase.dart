import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/constans/constants.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/models/request/pais_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/util/resources/pocketbase/functions_pocketbase.dart';

class PaisApiPocketBase {
  final Dio _dio;
  PaisApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaisesApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();

    final String filter = PaisRequestModel.toPocketBaseFilter(requestMap);
    const String url = '$kPocketBaseUrl/api/collections/Pais/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter, "expand": "modulo"};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaisApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    requestMap["codigo"] = await FunctionsPocketbase.getMaxCodigoCollection(dio: _dio, collection: "pais", field: "codigo");

    const String url = '$kPocketBaseUrl/api/collections/pais/records';
    final Response<String> response = await _dio.post('$url/', data: requestMap, queryParameters: <String, String>{"expand": "modulo"});
    return response;
  }

  Future<Response<dynamic>> updatePaisApi(PaisRequest request) async {
    final PaisRequestModel requestModel = PaisRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();

    final String id = await FunctionsPocketbase.getIdCollection(
      dio: _dio,
      collection: "pais",
      field: "codigo",
      value: request.codigo!,
    );

    final String url = '$kPocketBaseUrl/api/collections/pais/records/$id?';
    final Response<dynamic> response = await _dio.patch(url, data: requestMap, queryParameters: <String, dynamic>{"expand": "modulo"});

    return response;
  }
}
