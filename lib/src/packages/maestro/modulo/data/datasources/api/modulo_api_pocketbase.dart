import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/request/modulo_request_model_pb.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class ModuloApiPocketBase {
  final Dio _dio;
  ModuloApiPocketBase(this._dio);

  Future<Response<dynamic>> getModulosApi(ModuloRequest request) async {
    final ModuloRequestModelPB moduloRequestModel = ModuloRequestModelPB.fromRequestPB(request);
    final Map<String, dynamic> requestMap = moduloRequestModel.toJsonPB();
    requestMap["paquete"] = request.paquete == null ? null : await getPaqueteId(request.paquete!);

    final String filter = ModuloRequestModelPB.toPocketBaseFilter(requestMap);
    final String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter, "expand": "paquete"};

    final Response<dynamic> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setModuloApi(ModuloRequest request) async {
    final ModuloRequestModelPB moduloRequestModel = ModuloRequestModelPB.fromRequestPB(request);
    final Map<String, dynamic> requestMap = moduloRequestModel.toJsonPB();
    requestMap["modulo_codigo"] = await FunctionsPocketbase.getMaxCodigoCollection(dio: _dio, collection: "modulo", field: "modulo_codigo");
    requestMap["paquete"] = await getPaqueteId(request.paquete!);
    final String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Response<dynamic> response = await _dio.post('$url/', data: requestMap, queryParameters: <String, String>{"expand": "paquete"});
    return response;
  }

  Future<Response<dynamic>> updateModuloApi(EntityUpdate<ModuloRequest> request) async {
    final ModuloRequestModelPB moduloRequestModel = ModuloRequestModelPB.fromRequestPB(request.entity);
    final Map<String, dynamic> requestMap = moduloRequestModel.toJsonPB();
    if (requestMap.containsKey("paquete")) {
      requestMap["paquete"] = await getPaqueteId(request.entity.paquete!);
    }
    final String id = await FunctionsPocketbase.getIdCollection(
      dio: _dio,
      collection: "modulo",
      field: "modulo_codigo",
      value: request.id,
    );
    final String url = '$kPocketBaseUrl/api/collections/modulo/records/$id';

    final Response<dynamic> response = await _dio.patch(url, data: requestMap, queryParameters: <String, dynamic>{"expand": "paquete"});
    return response;
  }

  Future<String> getPaqueteId(int codigo) async {
    return await FunctionsPocketbase.getIdCollection(dio: _dio, collection: "paquete", field: "codigo", value: codigo);
  }

  Future<Response<dynamic>> getPaquetesApi() async {
    final String url = '$kPocketBaseUrl/api/collections/paquete/records';

    final Map<String, dynamic> queryParameters = <String, dynamic>{"filter": "(visible = true && activo = true)"};
    final Response<dynamic> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }
}
