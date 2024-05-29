import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/pagina_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/pagina_modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PaginaApiPocketBase {
  final Dio _dio;
  PaginaApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaginasApi(PaginaRequest paginaRequest) async {
    final String filter = await toPocketBaseFilter(paginaRequest);
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaginaApi(PaginaRequest paginaRequest) async {
    final int maxPaginaCodigo = await getMaxPaginaCodigo();
    final String moduloId = await getModuloId(paginaRequest.modulo!);
    paginaRequest.codigo = maxPaginaCodigo;
    moduloId.isEmpty ? paginaRequest.modulo : paginaRequest.modulo = moduloId;
    final Map<String, dynamic> jsonRequest = paginaRequest.toJson();
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Response<String> response = await _dio.post('$url/', data: jsonRequest);
    return response;
  }

  Future<Response<dynamic>> updatePaginaApi(PaginaRequest request) async {
    final String url = '$kPocketBaseUrl/api/collections/pagina/records/${request.id}?';
    final String moduloId = await getModuloId(request.modulo!);
    moduloId.isEmpty ? request.modulo : request.modulo = moduloId;
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
    List<PaginaModulo> paginaModulos = <PaginaModulo>[];
    final Response<dynamic> httpResponse = await getModulosApi();
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      paginaModulos = List<PaginaModulo>.from(resp.map((dynamic x) => PaginaModuloModel.fromJson(x)));
    }
    for (final PaginaModulo paginaModulo in paginaModulos) {
      if (paginaModulo.codigo.toString() == modulo || paginaModulo.nombre == modulo) {
        return paginaModulo.moduloId;
      }
    }
    return '';
  }

  Future<List<Pagina>> getModuloNombre(List<Pagina> response) async {
    final List<Pagina> data = <Pagina>[];
    List<PaginaModulo> paginaModulos = <PaginaModulo>[];
    final Response<dynamic> httpResponse = await getModulosApi();
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      paginaModulos = List<PaginaModulo>.from(resp.map((dynamic x) => PaginaModuloModel.fromJson(x)));
    }
    for (final Pagina pagina in response) {
      for (final PaginaModulo paginaModulo in paginaModulos) {
        if (paginaModulo.moduloId == pagina.modulo) {
          pagina.modulo = paginaModulo.nombre;
          data.add(pagina);
        }
      }
    }
    return data;
  }

  Future<String> toPocketBaseFilter(PaginaRequest paginaRequest) async {
    final List<String> conditions = <String>[];
    if (paginaRequest.nombre != null && paginaRequest.nombre!.isNotEmpty) {
      conditions.add('pagina_texto ~ "${paginaRequest.nombre!}"');
    }
    if (paginaRequest.codigo != null) {
      conditions.add('pagina_codigo = ${paginaRequest.codigo!}');
    }
    if (paginaRequest.isVisible != null) {
      conditions.add('pagina_visible = ${paginaRequest.isVisible!}');
    }
    if (paginaRequest.isActivo != null) {
      conditions.add('pagina_activo = ${paginaRequest.isActivo!}');
    }

    if (paginaRequest.modulo != null) {
      final String idModulo = await getModuloId(paginaRequest.modulo!);
      conditions.add('modulo = "${idModulo}"');
    }

    final String queryString = conditions.isNotEmpty ? conditions.join(' && ') : conditions.join();
    final String data = queryString.isNotEmpty ? '($queryString)' : '';
    return data;
  }

  String formatToYYYYMMDD(String fecha) {
    return fecha.replaceAll(RegExp(r'/'), '-');
  }
}
