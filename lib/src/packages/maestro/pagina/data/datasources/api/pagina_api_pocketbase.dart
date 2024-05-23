import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/filter_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/pagina_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PaginaApiPocketBase {
  final Dio _dio;
  PaginaApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaginasApi(PaginaRequest request) async {
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Map<String, String> queryParameters = <String, String>{"filter": FilterPocketBase().toPocketBaseFilter(request)};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaginaApi(PaginaRequest request) async {
    final int maxPaginaCodigo = await getMaxPaginaCodigo();
    request.paginaCodigo = maxPaginaCodigo;
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Response<String> response = await _dio.post('$url/', data: request.toJson());
    return response;
  }

  Future<Response<dynamic>> updatePaginaApi(PaginaRequest request) async {
    final PaginaRequest paginaRequest = PaginaRequest(
      paginaCodigo: request.paginaCodigo,
    );
    final Response<dynamic> paqueteUpdate = await getPaginasApi(paginaRequest);
    final Map<String, dynamic> responseData = jsonDecode(paqueteUpdate.data);
    final String paqueteId = responseData['items'][0]['id'];

    final String url = '$kPocketBaseUrl/api/collections/paquete/records/${paqueteId}?';

    final Response<dynamic> response = await _dio.patch(
      url,
      data: request.toJson(),
      options: Options(headers: <String, String>{'Authorization': kTokenPocketBase}),
    );
    return response;
  }

  Future<int> getMaxPaginaCodigo() async {
    int maxPaginaCodigo = 0;
    final Response<dynamic> httpResponse = await getPaginasApi(PaginaRequest());
    final dynamic responseData = jsonDecode(httpResponse.data);
    if (httpResponse.data != null && responseData.containsKey('items')) {
      final dynamic resp = responseData['items'];
      final List<Pagina> response = List<Pagina>.from(resp.map((dynamic x) => PaginaModel.fromJson(x)));
      if (response.isNotEmpty) {
        maxPaginaCodigo = response.map((Pagina pagina) => pagina.paginaCodigo).reduce((int a, int b) => a > b ? a : b);
        return maxPaginaCodigo + 1;
      }
    }
    return maxPaginaCodigo;
  }
}
