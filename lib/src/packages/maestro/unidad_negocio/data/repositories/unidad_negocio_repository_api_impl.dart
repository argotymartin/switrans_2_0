import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class UnidadNegocioRepositoryApiImpl extends BaseApiRepository implements AbstractUnidadNegocioRepository {
  final UnidadNegocioApi _api;

  UnidadNegocioRepositoryApiImpl(this._api);

  @override
  Future<DataState<List<UnidadNegocio>>> getUnidadNegociosService(UnidadNegocioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getUnidadNegociosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<UnidadNegocio> unidadNegocios =
          List<UnidadNegocio>.from(backendResponse.data.map((dynamic x) => UnidadNegocioModel.fromJson(x)));
      return DataSuccess<List<UnidadNegocio>>(unidadNegocios);
    }
    return DataFailed<List<UnidadNegocio>>(httpResponse.error!);
  }

  @override
  Future<DataState<UnidadNegocio>> setUnidadNegocioService(UnidadNegocioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setUnidadNegociosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final UnidadNegocio unidadNegocio = UnidadNegocioModel.fromJson(backendResponse.data);
      return DataSuccess<UnidadNegocio>(unidadNegocio);
    }
    return DataFailed<UnidadNegocio>(httpResponse.error!);
  }

  @override
  Future<DataState<UnidadNegocio>> updateUnidadNegocioService(EntityUpdate<UnidadNegocioRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateUnidadNegociosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final UnidadNegocio unidadNegocio = UnidadNegocioModel.fromJson(responseData.first);
          return DataSuccess<UnidadNegocio>(unidadNegocio);
        }
      }
    }
    return DataFailed<UnidadNegocio>(httpResponse.error!);
  }

  @override
  Future<DataState<List<UnidadNegocioEmpresa>>> getEmpresasService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getEmpresasApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<UnidadNegocioEmpresa> unidadNegocioEmpresas =
          List<UnidadNegocioEmpresa>.from(backendResponse.data.map((dynamic x) => UnidadNegocioEmpresaModel.fromJson(x)));
      return DataSuccess<List<UnidadNegocioEmpresa>>(unidadNegocioEmpresas);
    }
    return DataFailed<List<UnidadNegocioEmpresa>>(httpResponse.error!);

}
}
