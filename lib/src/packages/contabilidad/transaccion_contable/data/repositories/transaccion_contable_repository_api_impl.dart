import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/data/data.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class TransaccionContableRepositoryApiImpl extends BaseApiRepository implements AbstractTransaccionContableRepository {
  final TransaccionContableApi _api;

  TransaccionContableRepositoryApiImpl(this._api);

  @override
  Future<DataState<List<TransaccionContable>>> getTransaccionContablesService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTransaccionContablesApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<TransaccionContable> transaccionContables =
          List<TransaccionContable>.from(backendResponse.data.map((dynamic x) => TransaccionContableModel.fromJson(x)));
      return DataSuccess<List<TransaccionContable>>(transaccionContables);
    }
    return DataFailed<List<TransaccionContable>>(httpResponse.error!);
  }

  @override
  Future<DataState<TransaccionContable>> setTransaccionContableService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setTransaccionContableApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final TransaccionContable transaccionContable = TransaccionContableModel.fromJson(backendResponse.data);
      return DataSuccess<TransaccionContable>(transaccionContable);
    }
    return DataFailed<TransaccionContable>(httpResponse.error!);
  }

  @override
  Future<DataState<TransaccionContable>> updateTransaccionContableService(EntityUpdate<TransaccionContableRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateTransaccionContableApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final TransaccionContable transaccionContable = TransaccionContableModel.fromJson(responseData.first);
          return DataSuccess<TransaccionContable>(transaccionContable);
        }
      }
    }
    return DataFailed<TransaccionContable>(httpResponse.error!);
  }

  @override
  Future<DataState<List<TransaccionContableTipoImpuesto>>> getTipoImpuestosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTipoImpuestosApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<TransaccionContableTipoImpuesto> transaccionContableTipoImpuestos = List<TransaccionContableTipoImpuesto>.from(
        backendResponse.data.map((dynamic x) => TransaccionContableTipoImpuestoModel.fromJson(x)),
      );
      return DataSuccess<List<TransaccionContableTipoImpuesto>>(transaccionContableTipoImpuestos);
    }
    return DataFailed<List<TransaccionContableTipoImpuesto>>(httpResponse.error!);
  }
}
