import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class PocketbaseAPI {
  final Dio _dio;

  PocketbaseAPI(this._dio);

  Future<Response> getModulosAll() async {
    const url = '$kPocketBaseUrl/api/collections/paquete/records';
    final response = await _dio.get('$url/');

    final List<dynamic> paquetes = response.data['items'];

    for (var paquete in paquetes) {
      final responseModulos = await getModulosByPaquete(paquete["id"]);
      final List<dynamic> modulos = responseModulos.data['items'];

      for (var modulo in modulos) {
        final responsePaginas = await getPagesByModulo(modulo["id"]);
        final List<dynamic> paginas = responsePaginas.data['items'];
        modulo["paginas"] = paginas;
      }

      paquete["modulos"] = modulos;
    }

    return response;
  }

  Future<Response> getModulosByPaquete(String paquete) async {
    const url = '$kPocketBaseUrl/api/collections/modulo/records';
    final response = await _dio.get(
      '$url/',
      queryParameters: {
        "filter": "(paquete='$paquete')",
      },
    );
    return response;
  }

  Future<Response> getPagesByModulo(String modulo) async {
    const url = '$kPocketBaseUrl/api/collections/pagina/records';
    final response = await _dio.get(
      '$url/',
      queryParameters: {
        "filter": "(modulo='$modulo')",
      },
    );
    return response;
  }
}
