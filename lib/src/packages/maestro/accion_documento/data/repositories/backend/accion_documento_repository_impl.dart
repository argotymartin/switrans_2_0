import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class AccionDocumentoRepositoryImpl extends BaseApiRepository implements AbstractAccionDocumentoRepository {
  final AccionDocumentoApi _api;
  AccionDocumentoRepositoryImpl(this._api);

  @override
  Future<DataState<List<AccionDocumento>>> getAccionDocumentosService(AccionDocumentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getAccionDocumentosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<AccionDocumento> accionDocumentos =
      List<AccionDocumento>.from(backendResponse.data.map((dynamic x) => AccionDocumentoModel.fromJson(x)));
      return DataSuccess<List<AccionDocumento>>(accionDocumentos);
    }
    return DataFailed<List<AccionDocumento>>(httpResponse.error!);
  }

  @override
  Future<DataState<AccionDocumento>> setAccionDocumentoService(AccionDocumentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setAccionDocumentoApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final AccionDocumento accionDocumento = AccionDocumentoModel.fromJson(backendResponse.data);
      return DataSuccess<AccionDocumento>(accionDocumento);
    }
    return DataFailed<AccionDocumento>(httpResponse.error!);
  }

  @override
  Future<DataState<AccionDocumento>> updateAccionDocumentosService(EntityUpdate<AccionDocumentoRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateAccionDocumentosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final AccionDocumento accionDocumento = AccionDocumentoModel.fromJson(responseData.first);
          return DataSuccess<AccionDocumento>(accionDocumento);
        }
      }
    }
    return DataFailed<AccionDocumento>(httpResponse.error!);
  }

  @override
  Future<DataState<List<AccionDocumentoDocumento>>> getDocumentosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getDocumentosApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<AccionDocumentoDocumento> AccionDocumentoDocumentos =
      List<AccionDocumentoDocumento>.from(backendResponse.data.map((dynamic x) => AccionDocumentoDocumentoModel.fromJson(x)));
      return DataSuccess<List<AccionDocumentoDocumento>>(AccionDocumentoDocumentos);
    }
    return DataFailed<List<AccionDocumentoDocumento>>(httpResponse.error!);
  }
}
