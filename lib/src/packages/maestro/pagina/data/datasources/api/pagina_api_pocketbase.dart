import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/request/pagina_request_model_pb.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class PaginaApiPocketBase {
  final Dio _dio;
  PaginaApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaginasApi(PaginaRequest request) async {
    final PaginaRequestModelPB requestModel = PaginaRequestModelPB.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    requestMap["modulo"] = request.modulo == null ? null : await getModuloId(request.modulo!);

    final String filter = PaginaRequestModelPB.toPocketBaseFilter(requestMap);
    final String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter, "expand": "modulo"};
    final Response<dynamic> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaginaApi(PaginaRequest request) async {
    final PaginaRequestModelPB requestModel = PaginaRequestModelPB.fromRequestPB(request);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    requestMap["pagina_codigo"] = await FunctionsPocketbase.getMaxCodigoCollection(dio: _dio, collection: "pagina", field: "pagina_codigo");
    requestMap["modulo"] = await getModuloId(request.modulo!);

    final String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Response<String> response = await _dio.post('$url/', data: requestMap, queryParameters: <String, String>{"expand": "modulo"});
    return response;
  }

  Future<Response<dynamic>> updatePaginaApi(EntityUpdate<PaginaRequest> request) async {
    final PaginaRequestModelPB requestModel = PaginaRequestModelPB.fromRequestPB(request.entity);
    final Map<String, dynamic> requestMap = requestModel.toJsonPB();
    if (requestMap.containsKey("modulo")) {
      requestMap["modulo"] = await getModuloId(request.entity.modulo!);
    }

    final String id = await FunctionsPocketbase.getIdCollection(
      dio: _dio,
      collection: "pagina",
      field: "pagina_codigo",
      value: request.id,
    );

    final String url = '$kPocketBaseUrl/api/collections/pagina/records/$id?';
    final Response<dynamic> response = await _dio.patch(url, data: requestMap, queryParameters: <String, dynamic>{"expand": "modulo"});

    return response;
  }

  Future<Response<dynamic>> getModulosApi() async {
    final String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Map<String, dynamic> queryParameters = <String, dynamic>{"filter": "(modulo_visible = true && modulo_activo = true)"};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<String> getModuloId(int codigo) async {
    return await FunctionsPocketbase.getIdCollection(dio: _dio, collection: "modulo", field: "modulo_codigo", value: codigo);
  }
}
