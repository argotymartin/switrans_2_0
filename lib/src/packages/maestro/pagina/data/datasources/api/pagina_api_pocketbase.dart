import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/filter_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/pagina_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/pagina_modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PaginaApiPocketBase {
  final Dio _dio;
  PaginaApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaginasApi(PaginaRequest request) async {
    final String moduloId = request.moduloId == null ? '' : await getModuloId(request.moduloId!);
    moduloId.isEmpty ? request.moduloId : request.moduloId = moduloId;

    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Map<String, String> queryParameters = <String, String>{"filter": FilterPocketBase().toPocketBaseFilter(request)};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaginaApi(PaginaRequest request) async {
    final int maxPaginaCodigo = await getMaxPaginaCodigo();
    request.paginaCodigo = maxPaginaCodigo;
    final String moduloId = request.moduloId == null ? '' : await getModuloId(request.moduloId!);
    moduloId.isEmpty ? request.moduloId : request.moduloId = moduloId;
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

  Future<Response<dynamic>> getModulosApi() async {
    const String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Response<dynamic> response = await _dio.get(url);
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

  Future<String> getModuloId(String modulo) async {
    List<PaginaModulo> modulos = <PaginaModulo>[];
    final Response<dynamic> httpResponse = await getModulosApi();
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      modulos = List<PaginaModulo>.from(resp.map((dynamic x) => PaginaModuloModel.fromJson(x)));
    }
    for (final PaginaModulo paginaModulo in modulos) {
      if (paginaModulo.codigo.toString() == modulo || paginaModulo.nombre == modulo) {
        return paginaModulo.moduloId;
      }
    }
    return '';
  }

  Future<List<Pagina>> getModuloNombre(List<Pagina> response) async {
    final List<Pagina> data = <Pagina>[];
    List<PaginaModulo> modulos = <PaginaModulo>[];
    final Response<dynamic> httpResponse = await getModulosApi();
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      modulos = List<PaginaModulo>.from(resp.map((dynamic x) => PaginaModuloModel.fromJson(x)));
    }
    for (final Pagina pagina in response) {
      for (final PaginaModulo modulo in modulos) {
        if (modulo.codigo == pagina.modulo) {
          pagina.modulo = modulo.nombre;
          data.add(pagina);
        }
      }
    }
    return data;
  }


}
