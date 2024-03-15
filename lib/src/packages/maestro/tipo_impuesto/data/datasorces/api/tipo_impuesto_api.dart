import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class TipoImpuestoApi {
  final Dio _dio;
  TipoImpuestoApi(this._dio);

  Future<Response> getTipoImpuestosApi(TipoImpuestoRequest request) async {
    const url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final queryParameters = {"filter": request.toPocketBaseFilter()};
    final response = await _dio.get('$url/', queryParameters: queryParameters);
    return response;
  }

  Future<Response> setTipoImpuestoApi(TipoImpuestoRequest request) async {
    const url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final response = await _dio.post('$url/', data: request.toJson());
    return response;
  }
}
