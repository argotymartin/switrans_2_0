import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/filter_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_paquete_model.dart';

class ModuloApiPocketBase {
  final Dio _dio;
  ModuloApiPocketBase(this._dio);

  Future<Response> getModulosApi(ModuloRequest request) async {
    final paqueteId =  request.paquete == null ? '' : await getPaqueteId(request.paquete!);
    paqueteId.isEmpty ? request.paquete = request.paquete : request.paquete = paqueteId;
    const url = '$kPocketBaseUrl/api/collections/modulo/records';
    final queryParameters = {"filter": FilterPocketBase().toPocketBaseFilter(request)};
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
    List<ModuloPaquete> paquetes = [];
    final httpResponse = await getPaquetesApi();
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      paquetes = List<ModuloPaquete>.from(resp.map((x) => ModuloPaqueteModel.fromJson(x)));
    }
    for (ModuloPaquete package in paquetes) {
      if (package.codigo.toString() == paquete || package.nombre == paquete) {
        return package.paqueteId;
      }
    }
    return '';
  }

  Future<List<Modulo>> getPaqueteNombre(List<Modulo> response) async {
    final List<Modulo> data = [];
    List<ModuloPaquete> paquetes = [];
    final httpResponse = await getPaquetesApi();
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      paquetes = List<ModuloPaquete>.from(resp.map((x) => ModuloPaqueteModel.fromJson(x)));
    }
    for (Modulo modulo in response) {
      for (ModuloPaquete paquete in paquetes) {
        if (paquete.paqueteId == modulo.paquete) {
          modulo.paquete = paquete.nombre;
          data.add(modulo);
        }
      }
    }
    return data;
  }

}