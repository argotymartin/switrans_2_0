import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/paquete_model.dart';

class ModuloApi {
  final Dio _dio;
  ModuloApi(this._dio);

  Future<Response> getModulosApi(ModuloRequest request) async {
    const url = '$kPocketBaseUrl/api/collections/modulo/records';
    final queryParameters = {"filter": request.toPocketBaseFilter()};
    final response = await _dio.get('$url', queryParameters: queryParameters);
    return response;
  }

  Future<Response> setModuloApi(ModuloRequest request) async {
    final maxModuloCodigo = await getMaxModuloCodigo();
    final paqueteId = await getPaqueteId(request.paquete!);
    request.moduloCodigo = maxModuloCodigo;
    paqueteId.isEmpty ? request.paquete = request.paquete : request.paquete = paqueteId;
    const url = '$kPocketBaseUrl/api/collections/modulo/records';
    final response = await _dio.post('$url/', data: request.toJsonCreate());
    return response;
  }

  Future<Response> updateModuloApi(ModuloRequest request) async {
    final url = '$kPocketBaseUrl/api/collections/modulo/records/${request.moduloId}?';
    final paqueteId = await getPaqueteId(request.paquete!);
    paqueteId.isEmpty ? request.paquete = request.paquete : request.paquete = paqueteId;
    final response = await _dio.patch(url, data: request.toJson(),
        options: Options(headers: {'Authorization': kTokenPocketBase}));
    return response;
  }

  Future<Response> getPaquetesApi() async {
    const url = '$kPocketBaseUrl/api/collections/paquete/records';
    final response = await _dio.get(url);
    return response;
  }

  Future<int> getMaxModuloCodigo() async {
    int  maxModuloCodigo = 0;
    final httpResponse = await getModulosApi(ModuloRequest());
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      final response = List<Modulo>.from(resp.map((x) => ModuloModel.fromJson(x)));
      maxModuloCodigo = response.map((modulo) => modulo.moduloCodigo).reduce((a, b) => a > b ? a : b);
      return maxModuloCodigo + 1;
    }
    return maxModuloCodigo;
  }

  Future<String> getPaqueteId(String paquete) async {
    List<Paquete> paquetes = [];
    final httpResponse = await getPaquetesApi();
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      paquetes = List<Paquete>.from(resp.map((x) => PaqueteModel.fromJson(x)));
    }
    for (Paquete package in paquetes) {
      if (package.codigo.toString() == paquete || package.nombre == paquete) {
        return package.paqueteId;
      }
    }
    return '';
  }

}