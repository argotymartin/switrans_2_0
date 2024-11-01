import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/data/data.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class TipoImpuestoRepositoryImpl extends BaseApiRepository implements AbstractTipoImpuestoRepository {
  final TipoImpuestoApi _api;
  TipoImpuestoRepositoryImpl(this._api);

  @override
  Future<DataState<List<TipoImpuesto>>> getTipoImpuestosService(TipoImpuestoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTipoImpuestosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<TipoImpuesto> tipoImpuestos =
          List<TipoImpuesto>.from(backendResponse.data.map((dynamic x) => TipoImpuestoModel.fromJson(x)));
      return DataSuccess<List<TipoImpuesto>>(tipoImpuestos);
    }
    return DataFailed<List<TipoImpuesto>>(httpResponse.error!);
  }

  @override
  Future<DataState<TipoImpuesto>> setTipoImpuestoService(TipoImpuestoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setTipoImpuestoApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final TipoImpuesto tipoImpuesto = TipoImpuestoModel.fromJson(backendResponse.data);
      return DataSuccess<TipoImpuesto>(tipoImpuesto);
    }
    return DataFailed<TipoImpuesto>(httpResponse.error!);
  }

  @override
  Future<DataState<TipoImpuesto>> updateTipoImpuestosService(EntityUpdate<TipoImpuestoRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateTipoImpuestosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final TipoImpuesto tipoImpuesto = TipoImpuestoModel.fromJson(responseData.first);
          return DataSuccess<TipoImpuesto>(tipoImpuesto);
        }
      }
    }
    return DataFailed<TipoImpuesto>(httpResponse.error!);
  }
}
