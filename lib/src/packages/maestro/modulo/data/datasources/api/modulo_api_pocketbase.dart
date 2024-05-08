import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/filter_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_paquete_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class ModuloApiPocketBase {
  final Dio _dio;
  ModuloApiPocketBase(this._dio);

  Future<Response<dynamic>> getModulosApi(ModuloRequest request) async {
    final String paqueteId = request.paquete == null ? '' : await getPaqueteId(request.paquete!);
    paqueteId.isEmpty ? request.paquete : request.paquete = paqueteId;
    const String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Map<String, String> queryParameters = <String, String>{"filter": FilterPocketBase().toPocketBaseFilter(request)};
    final Response<String> response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response<dynamic>> setModuloApi(ModuloRequest request) async {
    final int maxModuloCodigo = await getMaxModuloCodigo();
    final String paqueteId = await getPaqueteId(request.paquete!);
    request.moduloCodigo = maxModuloCodigo;
    paqueteId.isEmpty ? request.paquete : request.paquete = paqueteId;
    const String url = '$kPocketBaseUrl/api/collections/modulo/records';
    final Response<String> response = await _dio.post('$url/', data: request.toJsonCreate());
    return response;
  }

  Future<Response<dynamic>> updateModuloApi(ModuloRequest request) async {
    final String url = '$kPocketBaseUrl/api/collections/modulo/records/${request.moduloId}?';
    final String paqueteId = await getPaqueteId(request.paquete!);
    paqueteId.isEmpty ? request.paquete : request.paquete = paqueteId;
    final Response<dynamic> response = await _dio.patch(
      url,
      data: request.toJson(),
      options: Options(headers: <String, String>{'Authorization': kTokenPocketBase}),
    );
    return response;
  }

  Future<Response<dynamic>> getPaquetesApi() async {
    const String url = '$kPocketBaseUrl/api/collections/paquete/records';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<int> getMaxModuloCodigo() async {
    int maxModuloCodigo = 0;
    final Response<dynamic> httpResponse = await getModulosApi(ModuloRequest());
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      final List<Modulo> response = List<Modulo>.from(resp.map((dynamic x) => ModuloModel.fromJson(x)));
      maxModuloCodigo = response.map((Modulo modulo) => modulo.moduloCodigo).reduce((int a, int b) => a > b ? a : b);
      return maxModuloCodigo + 1;
    }
    return maxModuloCodigo;
  }

  Future<String> getPaqueteId(String paquete) async {
    List<ModuloPaquete> paquetes = <ModuloPaquete>[];
    final Response<dynamic> httpResponse = await getPaquetesApi();
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      paquetes = List<ModuloPaquete>.from(resp.map((dynamic x) => ModuloPaqueteModel.fromJson(x)));
    }
    for (final ModuloPaquete package in paquetes) {
      if (package.codigo.toString() == paquete || package.nombre == paquete) {
        return package.paqueteId;
      }
    }
    return '';
  }

  Future<List<Modulo>> getPaqueteNombre(List<Modulo> response) async {
    final List<Modulo> data = <Modulo>[];
    List<ModuloPaquete> paquetes = <ModuloPaquete>[];
    final Response<dynamic> httpResponse = await getPaquetesApi();
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['items'];
      paquetes = List<ModuloPaquete>.from(resp.map((dynamic x) => ModuloPaqueteModel.fromJson(x)));
    }
    for (final Modulo modulo in response) {
      for (final ModuloPaquete paquete in paquetes) {
        if (paquete.paqueteId == modulo.paquete) {
          modulo.paquete = paquete.nombre;
          data.add(modulo);
        }
      }
    }
    return data;
  }
}
