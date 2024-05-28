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

  Future<Response<dynamic>> getPaginasApi(PaginaRequest request) async {
    final String filter = await toPocketBaseFilter(request);
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Map<String, String> queryParameters = <String, String>{"filter": filter};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaginaApi(PaginaRequest request) async {
    request.codigo = await getMaxPaginaCodigo();
    final Map<String, dynamic> jsonRequest = request.toJson();
    jsonRequest['modulo'] = getModuloId(request.modulo!);
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Response<String> response = await _dio.post('$url/', data: jsonRequest);
    return response;
  }

  Future<Response<dynamic>> updatePaginaApi(PaginaRequest request) async {
    final PaginaRequest paginaRequest = PaginaRequest(
      codigo: request.codigo,
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

  Future<String> getModuloId(int modulo) async {
    const String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Map<String, String> queryParameters = <String, String>{"filter": "(modulo_codigo=$modulo)"};
    final Response<dynamic> httpResponse = await _dio.get(url, queryParameters: queryParameters);

    if (httpResponse.data != null) {
      final String id = httpResponse.data['items'][0]["id"];
      return id;
    } else {
      return '';
    }


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

  Future<String> toPocketBaseFilter(PaginaRequest request) async{
    final List<String> conditions = <String>[];
    if (request.nombre != null && request.nombre!.isNotEmpty) {
      conditions.add('pagina_texto ~ "${request.nombre!}"');
    }
    if (request.codigo != null) {
      conditions.add('pagina_codigo = ${request.codigo!}');
    }
    if (request.isVisible != null) {
      conditions.add('pagina_visible = ${request.isVisible!}');
    }
    if (request.isActivo != null) {
      conditions.add('pagina_activo = ${request.isActivo!}');
    }

    if (request.modulo != null) {
      final String idModulo = await getModuloId(request.modulo!);
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
