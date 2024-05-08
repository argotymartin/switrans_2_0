import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class TipoImpuestoApi {
  final Dio _dio;
  TipoImpuestoApi(this._dio);

  Future<Response<dynamic>> getTipoImpuestosApi(TipoImpuestoRequest request) async {
    const String url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final Map<String, String> queryParameters = <String, String>{"filter": request.toPocketBaseFilter()};
    final Response<dynamic> response = await _dio.get('$url/', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setTipoImpuestoApi(TipoImpuestoRequest request) async {
    const String url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final Response<dynamic> response = await _dio.post('$url/', data: request.toJson());
    return response;
  }
}
