import 'package:switrans_2_0/src/packages/maestro/pais/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class PaisRepositoryImpl extends BaseApiRepository implements AbstractPaisRepository {
  final PaisApi _api;
  PaisRepositoryImpl(this._api);

  @override
  Future<DataState<List<Pais>>> getPaisesService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaisesApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<Pais> paises = List<Pais>.from(backendResponse.data.map((dynamic x) => PaisModel.fromJson(x)));
      return DataSuccess<List<Pais>>(paises);
    }
    return DataFailed<List<Pais>>(httpResponse.error!);
  }

  @override
  Future<DataState<Pais>> setPaisService(PaisRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setPaisApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final dynamic responseData = httpResponse.data['data'];
      final Pais pais = PaisModel.fromJson(responseData);
      return DataSuccess<Pais>(pais);
    }
    return DataFailed<Pais>(httpResponse.error!);
  }

  @override
  Future<DataState<Pais>> updatePaisService(EntityUpdate<PaisRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updatePaisApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final Map<String, dynamic> firstItem = responseData.first as Map<String, dynamic>;
          final Pais pais = PaisModel.fromJson(firstItem);
          return DataSuccess<Pais>(pais);
        }
      }
    }
    return DataFailed<Pais>(httpResponse.error!);
  }
}
