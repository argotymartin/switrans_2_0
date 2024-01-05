import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PocketbaseAPI {
  final Dio _dio;

  PocketbaseAPI(this._dio);

  Future<Response> getModulosAll() async {
    const url = '$kPocketBAseUrl/api/collections/modulo/records';
    final response = await _dio.get('$url/');
    //final paginas = getPagesByModulo(response.data['items']['id']);
    final List<dynamic> items = response.data['items'];

    List<Future<Response>> futures = [];

    for (var element in items) {
      final responseP = getPagesByModulo(element["id"]);
      futures.add(responseP);
    }
    List<Response> responses = await Future.wait(futures);
    //final response2 = items.map((x) => getPagesByModulo(x["id"])).toList();
    final reponsePaginas = responses.map((res) => res.data).toList();
    response.data['paginas'] = reponsePaginas[5];
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
