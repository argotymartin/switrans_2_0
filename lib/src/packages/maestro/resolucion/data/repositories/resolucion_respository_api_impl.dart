import 'package:switrans_2_0/src/packages/maestro/resolucion/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class ResolucionRespositoryApiImpl extends BaseApiRepository implements AbstractResolucionRepository {
  final ResolucionApi _resolucionApi;

  ResolucionRespositoryApiImpl(this._resolucionApi);

  @override
  Future<DataState<List<Resolucion>>> getResolucionesService(ResolucionRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getResolucionesApi(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['data'];
      final List<Resolucion> response = List<Resolucion>.from(resp.map((dynamic x) => ResolucionModel.fromApi(x)));
      return DataSuccess<List<Resolucion>>(response);
    }
    return DataFailed<List<Resolucion>>(httpResponse.error!);
  }

  @override
  Future<DataState<Resolucion>> setResolucionService(ResolucionRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.setResolucionesApi(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = httpResponse.data['data'];
      final Resolucion response = ResolucionModel.fromApi(dataJson);
      return DataSuccess<Resolucion>(response);
    }
    return DataFailed<Resolucion>(httpResponse.error!);
  }

  @override
  Future<DataState<Resolucion>> updateResolucionService(EntityUpdate<ResolucionRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.updateResolucionesApi(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['data'];
      final List<Resolucion> response = List<Resolucion>.from(resp.map((dynamic x) => ResolucionModel.fromApi(x)));
      return DataSuccess<Resolucion>(response.first);
    }
    return DataFailed<Resolucion>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ResolucionDocumento>>> getDocumentosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getDocumentosApi());
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['data'];
      final List<ResolucionDocumento> response =
          List<ResolucionDocumento>.from(resp.map((dynamic x) => ResolucionDocumentoModel.fromApi(x)));
      return DataSuccess<List<ResolucionDocumento>>(response);
    }
    return DataFailed<List<ResolucionDocumento>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ResolucionEmpresa>>> getEmpresasService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getEmpresasApi());
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['data'];
      final List<ResolucionEmpresa> response = List<ResolucionEmpresa>.from(resp.map((dynamic x) => ResolucionEmpresaModel.fromApi(x)));
      return DataSuccess<List<ResolucionEmpresa>>(response);
    }
    return DataFailed<List<ResolucionEmpresa>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<ResolucionCentroCosto>>> getCentroCostoService(ResolucionEmpresa request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _resolucionApi.getCentroCostoApi(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data['data'];
      final List<ResolucionCentroCosto> response =
          List<ResolucionCentroCosto>.from(resp.map((dynamic x) => ResolucionCentroCostoModel.fromApi(x)));
      return DataSuccess<List<ResolucionCentroCosto>>(response);
    }
    return DataFailed<List<ResolucionCentroCosto>>(httpResponse.error!);
  }
}
