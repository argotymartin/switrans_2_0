import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/models/request/unidad_negocio_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/functions_postgresql.dart';

const String endPoint = "api/v1/maestro/unidad_negocios";

class UnidadNegocioApi {
  final Dio _dio;
  UnidadNegocioApi(this._dio);

  Future<Response<dynamic>> getUnidadNegociosApi(UnidadNegocioRequest request) async {
    final UnidadNegocioRequestModel requestModel = UnidadNegocioRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlMaestro/$endPoint';
    final Response<dynamic> response = await _dio.get(url, queryParameters: requestModel.toJson());
    return response;
  }

  Future<Response<dynamic>> setUnidadNegociosApi(UnidadNegocioRequest request) async {
    final UnidadNegocioRequestModel requestModel = UnidadNegocioRequestModel.fromRequest(request);

    final String url = '$kBackendBaseUrlMaestro/$endPoint/crear';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.post(url, data: params);
    return response;
  }

  Future<Response<dynamic>> updateUnidadNegociosApi(UnidadNegocioRequest request) async {
    final UnidadNegocioRequestModel requestModel = UnidadNegocioRequestModel.fromRequest(request);

    final String url = '$kBackendBaseUrlMaestro/$endPoint/actualizar/${request.codigo}';
    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> responseUpdate = await _dio.put(url, data: params);
    final Response<dynamic> response;
    if (responseUpdate.statusCode == 204) {
      final UnidadNegocioRequest unidadNegocioRequest = UnidadNegocioRequest(codigo: request.codigo);
      response = await getUnidadNegociosApi(unidadNegocioRequest);
    } else {
      response = responseUpdate;
    }
    return response;
  }

  Future<Response<dynamic>> getEmpresasApi() async {
    const String sql =
        """SELECT EMPRESA_CODIGO, EMPRESA_NOMBRE FROM TB_EMPRESA WHERE EMPRESA_APLICA_PREFACTURA = TRUE ORDER BY EMPRESA_NOMBRE ASC """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }
}
