import 'dart:convert';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/datasources/api/paquete_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/models/paquete_model.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/repositories/abstract_paquete_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class PaqueteRepositoryImpl extends BaseApiRepository implements AbstractPaqueteRepository {
  final PaqueteApiPocketBase _api;
  PaqueteRepositoryImpl(this._api);

  @override
  Future<DataState<List<Paquete>>> getPaquetesService(PaqueteRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaquetesApi(request));
    if (httpResponse.data != null) {
      final List<dynamic> items = httpResponse.data['items'];
      final List<Paquete> response = items.map((dynamic item) => PaqueteModel.fromJson(item)).toList();
      return DataSuccess<List<Paquete>>(response);
    }
    return DataFailed<List<Paquete>>(httpResponse.error!);
  }

  @override
  Future<DataState<Paquete>> setPaqueteService(PaqueteRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setPaqueteApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = json.decode(httpResponse.data);
      final Paquete response = PaqueteModel.fromJson(responseData);
      return DataSuccess<Paquete>(response);
    }
    return DataFailed<Paquete>(httpResponse.error!);
  }

  @override
  Future<DataState<Paquete>> updatePaqueteService(EntityUpdate<PaqueteRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updatePaqueteApi(request));
    if (httpResponse.data != null) {
      final Paquete response = PaqueteModel.fromJson(httpResponse.data);
      return DataSuccess<Paquete>(response);
    }
    return DataFailed<Paquete>(httpResponse.error!);
  }
}
