import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/constans/constants.dart';

class PBClienteAPI {
  final Dio _dio;

  PBClienteAPI(this._dio);

  Future<Response<dynamic>> getClienteAll() async {
    const String url = '$kPocketBaseUrl/api/collections/cliente/records';
    final Response<dynamic> response = await _dio.get('$url/');
    return response;
  }

  Future<Response<dynamic>> getCliente(String parm) async {
    const String url = '$kPocketBaseUrl/api/collections/cliente/records';
    final Response<dynamic> response = await _dio.get(
      '$url/',
      queryParameters: <String, dynamic>{
        "filter": "(cliente_nombre~'$parm')",
      },
    );
    return response;
  }

  Future<Response<dynamic>> getDataEmpresas() async {
    const String url = '$kPocketBaseUrl/api/collections/empresa/records';
    final Response<dynamic> response = await _dio.get('$url/');
    return response;
  }
}
