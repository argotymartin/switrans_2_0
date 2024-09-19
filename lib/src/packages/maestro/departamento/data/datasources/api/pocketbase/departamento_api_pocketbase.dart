import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/models/request/departamento_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/request/departamento_request.dart';
import 'package:switrans_2_0/src/util/resources/pocketbase/functions_pocketbase.dart';

class DepartamentoApiPocketBase {
  final Dio _dio;
  DepartamentoApiPocketBase(this._dio);

  Future<Response<dynamic>> getDepartamentosApi1(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();

    final String filter = DepartamentoRequestModel.toPocketBaseFilter(requestMap);
    final String url = '$kPocketBaseUrl/api/collections/Departamento/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter, "expand": "modulo"};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaisApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    requestMap["codigo"] = await FunctionsPocketbase.getMaxCodigoCollection(dio: _dio, collection: "departamento", field: "codigo");

    final String url = '$kPocketBaseUrl/api/collections/departamento/records';
    final Response<String> response = await _dio.post('$url/', data: requestMap, queryParameters: <String, String>{"expand": "modulo"});
    return response;
  }

  Future<Response<dynamic>> updateDepartamentoApi(DepartamentoRequest request) async {
    final DepartamentoRequestModel requestModel = DepartamentoRequestModel.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();

    final String id = await FunctionsPocketbase.getIdCollection(
      dio: _dio,
      collection: "departamento",
      field: "codigo",
      value: request.codigo!,
    );

    final String url = '$kPocketBaseUrl/api/collections/pais/records/$id?';
    final Response<dynamic> response = await _dio.patch(url, data: requestMap, queryParameters: <String, dynamic>{"expand": "pais"});

    return response;
  }
}
