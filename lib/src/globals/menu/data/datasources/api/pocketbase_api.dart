import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/constans/constants.dart';

class PocketbaseAPI {
  final Dio _dio;

  PocketbaseAPI(this._dio);

  Future<Response<dynamic>> getModulosAll() async {
    const String url = '$kPocketBaseUrl/api/collections/paquete/records';

    final Response<dynamic> response = await _dio.get(
      '$url/',
      queryParameters: <String, dynamic>{
        "filter": "(visible=true)",
      },
    );

    final List<dynamic> paquetes = response.data['items'];

    for (final dynamic paquete in paquetes) {
      final Response<dynamic> responseModulos = await getModulosByPaquete(paquete["id"]);
      final List<dynamic> modulos = responseModulos.data['items'];

      for (final dynamic modulo in modulos) {
        final Response<dynamic> responsePaginas = await getPagesByModulo(modulo["id"]);
        final List<dynamic> paginas = responsePaginas.data['items'];
        paginas.sort((dynamic a, dynamic b) {
          return a["pagina_texto"].compareTo(b["pagina_texto"]);
        });
        modulo["paginas"] = paginas;
      }
      modulos.sort((dynamic a, dynamic b) => a["modulo_nombre"].compareTo(b["modulo_nombre"]));
      paquete["modulos"] = modulos;
    }
    paquetes.sort((dynamic a, dynamic b) => a["nombre"].compareTo(b["nombre"]));
    return response;
  }

  Future<Response<dynamic>> getModulosByPaquete(String paquete) async {
    const String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Response<dynamic> response = await _dio.get(
      '$url/',
      queryParameters: <String, dynamic>{
        "filter": "(paquete='$paquete')",
      },
    );
    return response;
  }

  Future<Response<dynamic>> getPagesByModulo(String modulo) async {
    const String url = '$kPocketBaseUrl/api/collections/pagina/records';
    final Response<dynamic> response = await _dio.get(
      '$url/',
      queryParameters: <String, String>{
        "filter": "(modulo='$modulo')",
      },
    );
    return response;
  }
}
