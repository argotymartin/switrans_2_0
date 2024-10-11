import 'dart:convert';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/datasources/api/modulo_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_paquete_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class ModuloRepositoryImpl extends BaseApiRepository implements AbstractModuloRepository {
  final ModuloApiPocketBase _api;
  ModuloRepositoryImpl(this._api);

  @override
  Future<DataState<List<Modulo>>> getModulosService(ModuloRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getModulosApi(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = jsonDecode(httpResponse.data);
      final dynamic items = dataJson['items'];
      final List<Modulo> response = List<Modulo>.from(items.map((dynamic x) => ModuloModel.fromJsonPB(x)));
      return DataSuccess<List<Modulo>>(response);
    }
    return DataFailed<List<Modulo>>(httpResponse.error!);
  }

  @override
  Future<DataState<Modulo>> setModuloService(ModuloRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setModuloApi(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = jsonDecode(httpResponse.data);
      final Modulo response = ModuloModel.fromJsonPB(dataJson);
      return DataSuccess<Modulo>(response);
    }
    return DataFailed<Modulo>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ModuloPaquete>>> getPaquetesService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaquetesApi());
    if (httpResponse.data != null) {
      final dynamic jsonData = jsonDecode(httpResponse.data);
      final dynamic resp = jsonData['items'];
      final List<ModuloPaquete> response = List<ModuloPaquete>.from(resp.map((dynamic x) => ModuloPaqueteModel.fromJson(x)));
      return DataSuccess<List<ModuloPaquete>>(response);
    }
    return DataFailed<List<ModuloPaquete>>(httpResponse.error!);
  }

  @override
  Future<DataState<Modulo>> updateModuloService(EntityUpdate<ModuloRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateModuloApi(request));
    if (httpResponse.data != null) {
      final Modulo response = ModuloModel.fromJsonPB(httpResponse.data);
      return DataSuccess<Modulo>(response);
    }
    return DataFailed<Modulo>(httpResponse.error!);
  }
}
