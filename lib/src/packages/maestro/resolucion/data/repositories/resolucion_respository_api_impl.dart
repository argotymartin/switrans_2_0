import 'package:switrans_2_0/src/packages/maestro/resolucion/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class ResolucionRespositoryApiImpl extends BaseApiRepository implements AbstractResolucionRepository {
  final ResolucionApi _resolucionApi;

  ResolucionRespositoryApiImpl(this._resolucionApi);

  @override
  Future<DataState<List<Resolucion>>> getResolucionesService(ResolucionRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getResolucionesApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<Resolucion> resoluciones = List<Resolucion>.from(backendResponse.data.map((dynamic x) => ResolucionModel.fromApi(x)));
      return DataSuccess<List<Resolucion>>(resoluciones);
    }
    return DataFailed<List<Resolucion>>(httpResponse.error!);
  }

  @override
  Future<DataState<Resolucion>> setResolucionService(ResolucionRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.setResolucionesApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final Resolucion resolucion = ResolucionModel.fromApi(backendResponse.data);
      return DataSuccess<Resolucion>(resolucion);
    }
    return DataFailed<Resolucion>(httpResponse.error!);
  }

  @override
  Future<DataState<Resolucion>> updateResolucionService(EntityUpdate<ResolucionRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.updateResolucionesApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<Resolucion> resoluciones = List<Resolucion>.from(backendResponse.data.map((dynamic x) => ResolucionModel.fromApi(x)));
      return DataSuccess<Resolucion>(resoluciones.first);
    }
    return DataFailed<Resolucion>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ResolucionDocumento>>> getDocumentosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getDocumentosApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<ResolucionDocumento> resoluciones =
          List<ResolucionDocumento>.from(backendResponse.data.map((dynamic x) => ResolucionDocumentoModel.fromApi(x)));
      return DataSuccess<List<ResolucionDocumento>>(resoluciones);
    }
    return DataFailed<List<ResolucionDocumento>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ResolucionEmpresa>>> getEmpresasService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getEmpresasApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<ResolucionEmpresa> empresas =
          List<ResolucionEmpresa>.from(backendResponse.data.map((dynamic x) => ResolucionEmpresaModel.fromApi(x)));
      return DataSuccess<List<ResolucionEmpresa>>(empresas);
    }
    return DataFailed<List<ResolucionEmpresa>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ResolucionCentroCosto>>> getCentroCostoService(ResolucionEmpresa request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getCentroCostoApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<ResolucionCentroCosto> centroCostos =
          List<ResolucionCentroCosto>.from(backendResponse.data.map((dynamic x) => ResolucionCentroCostoModel.fromApi(x)));
      return DataSuccess<List<ResolucionCentroCosto>>(centroCostos);
    }
    return DataFailed<List<ResolucionCentroCosto>>(httpResponse.error!);
  }
}
