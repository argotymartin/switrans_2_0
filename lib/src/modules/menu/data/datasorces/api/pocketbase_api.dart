import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PocketbaseAPI {
  final Dio _dio;

  PocketbaseAPI(this._dio);

  Future<Response> getModulosAll() async {
    const url = '$kPocketBAseUrl/api/collections/modulo/records';
    final response = await _dio.get('$url/');

    final List<dynamic> items = response.data['items'];

    for (var element in items) {
      final responseP = await getPagesByModulo(element["id"]);
      element["paginas"] = responseP.data['items'];
    }

    return response;
  }

  Future<Response> getPagesByModulo(String modulo) async {
    const url = '$kPocketBAseUrl/api/collections/pagina/records';
    final response = await _dio.get(
      '$url/',
      queryParameters: {
        "filter": "(modulo='$modulo')",
      },
    );
    return response;
  }
}
