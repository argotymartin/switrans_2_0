import 'package:switrans_2_0/src/packages/maestro/pais/data/datasources/api/backend/pais_api.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/models/pais_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/repositories/abstract_pais_repository.dart';
import 'package:switrans_2_0/src/util/resources/backend/backend_response.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class PaisRepositoryImpl extends BaseApiRepository implements AbstractPaisRepository {
  final PaisApi _api;
  PaisRepositoryImpl(this._api);

  @override
  Future<DataState<List<Pais>>> getPaisesService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaisesApi(request));
    if (httpResponse.data != null) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      final List<Pais> response = List<Pais>.from(resp.data.map((dynamic x) => PaisModel.fromJson(x)));
      return DataSuccess<List<Pais>>(response);
    }
    return DataFailed<List<Pais>>(httpResponse.error!);
  }

  @override
  Future<DataState<Pais>> setPaisService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setPaisApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final dynamic responseData = httpResponse.data['data'];
      final Pais response = PaisModel.fromJson(responseData);
      return DataSuccess<Pais>(response);
    }
    return DataFailed<Pais>(httpResponse.error!);
  }

  @override
  Future<DataState<Pais>> updatePaisService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updatePaisApi(request));

    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      if (resp.success) {
        final dynamic responseData = resp.data;
        if (responseData is List && responseData.isNotEmpty) {
          final Map<String, dynamic> firstItem = responseData.first as Map<String, dynamic>;
          final Pais response = PaisModel.fromJson(firstItem);
          return DataSuccess<Pais>(response);
        }
      }
    }
    return DataFailed<Pais>(httpResponse.error!);
  }
}
