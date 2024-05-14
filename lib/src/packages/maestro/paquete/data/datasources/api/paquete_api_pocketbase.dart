import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/models/filter_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/models/paquete_model.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PaqueteApiPocketBase {
  final Dio _dio;
  PaqueteApiPocketBase(this._dio);

  Future<Response<dynamic>> getPaquetesApi(PaqueteRequest request) async {
    const String url = '$kPocketBaseUrl/api/collections/paquete/records';
    final Map<String, String> queryParameters = <String, String>{"filter": FilterPocketBase().toPocketBaseFilter(request)};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setPaqueteApi(PaqueteRequest request) async {
    final int maxPaqueteCodigo = await getMaxPaqueteCodigo();
    request.paqueteCodigo = maxPaqueteCodigo;
    const String url = '$kPocketBaseUrl/api/collections/paquete/records';
    final Response<String> response = await _dio.post('$url/', data: request.toJsonCreate());
    return response;
  }

  Future<Response<dynamic>> updatePaqueteApi(PaqueteRequest request) async {
    final String url = '$kPocketBaseUrl/api/collections/paquete/records/${request.paqueteId}?';
    final Response<dynamic> response = await _dio.patch(
      url,
      data: request.toJson(),
      options: Options(headers: <String, String>{'Authorization': kTokenPocketBase}),
    );
    return response;
  }

  Future<int> getMaxPaqueteCodigo() async {
    int maxPaqueteCodigo = 0;
    final Response<dynamic> httpResponse = await getPaquetesApi(PaqueteRequest());
    final dynamic responseData = jsonDecode(httpResponse.data);
    if (httpResponse.data != null && responseData.containsKey('items')) {
      final dynamic resp = responseData['items'];
      final List<Paquete> response = List<Paquete>.from(resp.map((dynamic x) => PaqueteModel.fromJson(x)));
      if (response.isNotEmpty) {
        maxPaqueteCodigo = response.map((Paquete paquete) => paquete.paqueteCodigo).reduce((int a, int b) => a > b ? a : b);
        return maxPaqueteCodigo + 1;
      }
    }
    return maxPaqueteCodigo;
  }
}
