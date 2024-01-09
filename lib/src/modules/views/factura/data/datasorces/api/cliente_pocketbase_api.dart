import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class ClientePocketbaseAPI {
  final Dio _dio;

  ClientePocketbaseAPI(this._dio);

  Future<Response> getClienteAll() async {
    const url = '$kPocketBAseUrl/api/collections/cliente/records';
    final response = await _dio.get('$url/');
    return response;
  }

  Future<Response> getCliente(String parm) async {
    const url = '$kPocketBAseUrl/api/collections/cliente/records';
    final response = await _dio.get(
      '$url/',
      queryParameters: {
        "filter": "(cliente_nombre~'$parm')",
      },
    );
    return response;
  }
}
