import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class TipoImpuestoApi {
  final Dio _dio;
  TipoImpuestoApi(this._dio);

  Future<Response> getTipoImpuestosApi(TipoImpuestoRequest request) async {
    const url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    //final queryParameters = request.toJson();

    String data = "(";
    if (request.nombre.isNotEmpty) {
      data += "nombre~'${request.nombre}'";
    }
    if (request.codigo != null) {
      data += "codigo=${request.codigo}";
    }
    data += ")";
    print(data);
    final queryParameters = {"filter": data};
    final response = await _dio.get('$url/', queryParameters: queryParameters);
    return response;
  }

  Future<Response> setTipoImpuestoApi(TipoImpuestoRequest request) async {
    const url = '$kPocketBaseUrl/api/collections/tipo_impuesto/records';
    final response = await _dio.post('$url/', data: request.toJson());
    return response;
  }
}
