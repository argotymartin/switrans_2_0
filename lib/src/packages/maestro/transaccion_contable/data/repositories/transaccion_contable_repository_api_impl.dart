import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/datasources/api/transaccion_contable_api.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/transaccion_contable_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/transaccion_contable_tipo_impuesto_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/repositories/abstract_transaccion_contable_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class TransaccionContableRepositoryApiImpl extends BaseApiRepository implements AbstractTransaccionContableRepository {
  final TransaccionContableApi _api;

  TransaccionContableRepositoryApiImpl(this._api);

  @override
  Future<DataState<List<TransaccionContable>>> getTransaccionContablesService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTransaccionContableApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);

      final List<TransaccionContable> response = List<TransaccionContable>.from(
        backendResponse.data.map((dynamic x) => TransaccionContableModel.fromJson(x)),
      );

      return DataSuccess<List<TransaccionContable>>(response);
    }
    return DataFailed<List<TransaccionContable>>(httpResponse.error!);
  }

  @override
  Future<DataState<TransaccionContable>> setTransaccionContableService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setTransaccionContableApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final TransaccionContable response = TransaccionContableModel.fromJson(backendResponse.data);
      return DataSuccess<TransaccionContable>(response);
    }
    return DataFailed<TransaccionContable>(httpResponse.error!);
  }

  @override
  Future<DataState<TransaccionContable>> updateTransaccionContableService(EntityUpdate<TransaccionContableRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateTransaccionContableApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final TransaccionContable response = TransaccionContableModel.fromJson(backendResponse.data);
      return DataSuccess<TransaccionContable>(response);
    }
    return DataFailed<TransaccionContable>(httpResponse.error!);
  }

  @override
  Future<DataState<List<TransaccionContableTipoImpuesto>>> getTipoImpuestosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTipoImpuestosApi());

    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<TransaccionContableTipoImpuesto> response = List<TransaccionContableTipoImpuesto>.from(
        backendResponse.data.map((dynamic x) => TransaccionContableTipoImpuestoModel.fromJson(x)),
      );
      return DataSuccess<List<TransaccionContableTipoImpuesto>>(response);
    }
    return DataFailed<List<TransaccionContableTipoImpuesto>>(httpResponse.error!);
  }
}
