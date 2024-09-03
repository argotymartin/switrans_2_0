import 'dart:convert';
import 'package:switrans_2_0/src/packages/maestro/pais/data/datasources/api/pais_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/models/pais_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/repositories/abstract_pais_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class PaisRepositoryImpl extends BaseApiRepository implements AbstractPaisRepository {
  final PaisApiPocketBase _api;
  PaisRepositoryImpl(this._api);

  @override
  Future<DataState<List<Pais>>> getPaisesService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaisesApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = jsonDecode(httpResponse.data);
      final List<dynamic> items = responseData['items'];
      final List<Pais> response = items.map((dynamic item) => PaisModel.fromJson(item)).toList();
      return DataSuccess<List<Pais>>(response);
    }
    return DataFailed<List<Pais>>(httpResponse.error!);
  }

  @override
  Future<DataState<Pais>> setPaisService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setPaisApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = json.decode(httpResponse.data);
      final Pais response = PaisModel.fromJson(responseData);
      return DataSuccess<Pais>(response);
    }
    return DataFailed<Pais>(httpResponse.error!);
  }

  @override
  Future<DataState<Pais>> updatePaisService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updatePaisApi(request));
    if (httpResponse.data != null) {
      final Pais response = PaisModel.fromJson(httpResponse.data);
      return DataSuccess<Pais>(response);
    }
    return DataFailed<Pais>(httpResponse.error!);
  }
}
