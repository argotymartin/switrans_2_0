import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class TipoImpuestoApi {
  final Dio _dio;
  TipoImpuestoApi(this._dio);

  Future<Response> getTipoImpuestosApi() async {
    const url = '$kPocketBaseUrl/api/collections/cliente/records';
    final response = await _dio.get('$url/');
    return response;
  }
}
