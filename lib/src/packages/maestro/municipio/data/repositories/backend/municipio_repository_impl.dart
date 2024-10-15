import 'package:switrans_2_0/src/packages/maestro/municipio/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class MunicipioRepositoryImpl extends BaseApiRepository implements AbstractMunicipioRepository {
  final MunicipioApi _api;
  MunicipioRepositoryImpl(this._api);

  @override
  Future<DataState<List<Municipio>>> getMunicipiosService(MunicipioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getMunicipiosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<Municipio> municipios = List<Municipio>.from(backendResponse.data.map((dynamic x) => MunicipioModel.fromJson(x)));
      return DataSuccess<List<Municipio>>(municipios);
    }
    return DataFailed<List<Municipio>>(httpResponse.error!);
  }

  @override
  Future<DataState<Municipio>> setMunicipioService(MunicipioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setMunicipioApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final Municipio municipio = MunicipioModel.fromJson(backendResponse.data);
      return DataSuccess<Municipio>(municipio);
    }
    return DataFailed<Municipio>(httpResponse.error!);
  }

  @override
  Future<DataState<Municipio>> updateMunicipioService(EntityUpdate<MunicipioRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateMunicipioApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final Map<String, dynamic> firstItem = responseData.first as Map<String, dynamic>;
          final Municipio municipio = MunicipioModel.fromJson(firstItem);
          return DataSuccess<Municipio>(municipio);
        }
      }
    }
    return DataFailed<Municipio>(httpResponse.error!);
  }

  @override
  Future<DataState<List<MunicipioDepartamento>>> getDepartamentosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getDepartamentosApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<MunicipioDepartamento> municipioDepartamentos =
          List<MunicipioDepartamento>.from(backendResponse.data.map((dynamic x) => MunicipioDepartamentoModel.fromJson(x)));
      return DataSuccess<List<MunicipioDepartamento>>(municipioDepartamentos);
    }
    return DataFailed<List<MunicipioDepartamento>>(httpResponse.error!);
  }
}
