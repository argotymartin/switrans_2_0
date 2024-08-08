import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/models/request/tipo_impuesto_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';
import 'package:switrans_2_0/src/util/resources/pocketbase/functions_pocketbase.dart';

class TipoImpuestoApi {
  final Dio _dio;
  TipoImpuestoApi(this._dio);

  Future<Response<dynamic>> getTipoImpuestosApi(TipoImpuestoRequest request) async {
    final TipoImpuestoRequestModel requestModel = TipoImpuestoRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJson();

    final String filter = TipoImpuestoRequestModel.toPocketBaseFilter(requestMap);
    const String url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter};

    final Response<dynamic> response = await _dio.get('$url/', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setTipoImpuestoApi(TipoImpuestoRequest request) async {
    final TipoImpuestoRequestModel requestModel = TipoImpuestoRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJson();
    requestMap["codigo"] = await FunctionsPocketbase.getMaxCodigoCollection(dio: _dio, collection: "tipo_impuesto", field: "codigo");
    const String url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final Response<dynamic> response = await _dio.post('$url/', data: requestMap);
    return response;
  }

  Future<Response<dynamic>> updateTipoImpuestoApi(TipoImpuestoRequest request) async {
    final TipoImpuestoRequestModel requestModel = TipoImpuestoRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJson();
    final String id = await FunctionsPocketbase.getIdCollection(
      dio: _dio,
      collection: "tipo_impuesto",
      field: "codigo",
      value: request.codigo!,
    );
    final String url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records/$id';
    final Response<dynamic> response = await _dio.patch(url, data: requestMap);
    return response;
  }
}
