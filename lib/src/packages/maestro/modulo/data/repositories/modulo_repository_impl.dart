import 'package:switrans_2_0/src/packages/maestro/modulo/data/datasources/api/modulo_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_paquete_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class ModuloRepositoryImpl extends BaseApiRepository implements AbstractModuloRepository {
  final ModuloApiPocketBase _api;
  ModuloRepositoryImpl(this._api);

  @override
  Future<DataState<List<Modulo>>> getModulosService(ModuloRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.getModulosApi(request));
    if (httpResponse.data != null) {
      final items = httpResponse.data['items'];
      final response = List<Modulo>.from(items.map((x) => ModuloModel.fromJson(x)));
      final data = await _api.getPaqueteNombre(response);
      return DataSuccess(data);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<Modulo>> setModuloService(ModuloRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.setModuloApi(request));
    if (httpResponse.data != null) {
      final Modulo response = ModuloModel.fromJson(httpResponse.data);
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<List<ModuloPaquete>>> getPaquetesService() async {
    final httpResponse = await getStateOf(request: () => _api.getPaquetesApi());
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      final List<ModuloPaquete> response = List<ModuloPaquete>.from(resp.map((x) => ModuloPaqueteModel.fromJson(x)));
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<Modulo>> updateModuloService(ModuloRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.updateModuloApi(request));
    if (httpResponse.data != null) {
      final Modulo response = ModuloModel.fromJson(httpResponse.data);
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

}
