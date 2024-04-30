import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/paquete_model.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/datasources/db/modulo_api.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/models/modulo_model.dart';

class ModuloRepositoryImpl extends BaseApiRepository implements AbstractModuloRepository {
  final ModuloApi _api;
  ModuloRepositoryImpl(this._api);

  @override
  Future<DataState<List<Modulo>>> getModulosService(ModuloRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.getModulosApi(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      final response = List<Modulo>.from(resp.map((x) => ModuloModel.fromJson(x)));
      return DataSuccess(response);
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
  Future<DataState<List<Paquete>>> getPaquetesService() async {
    final httpResponse = await getStateOf(request: () => _api.getPaquetesApi());
    if (httpResponse.data != null) {
      final resp = httpResponse.data['items'];
      final List<Paquete> response = List<Paquete>.from(resp.map((x) => PaqueteModel.fromJson(x)));
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