import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/datasources/db/transaccion_contable_db.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/transaccion_contable_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/models/transaccion_contable_tipo_impuesto_model.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/repositories/abstract_transaccion_contable_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class TransaccionContableRepositoryDBImpl extends BaseApiRepository implements AbstractTransaccionContableRepository {
  final TransaccionContableDB _transaccionContableDB;

  TransaccionContableRepositoryDBImpl(this._transaccionContableDB);

  @override
  Future<DataState<List<TransaccionContable>>> getTransaccionContablesService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _transaccionContableDB.getTransaccionContableDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;

      final List<TransaccionContable> response = List<TransaccionContable>.from(
        resp.map((Map<String, dynamic> x) => TransaccionContableModel.fromDB(x)),
      );

      return DataSuccess<List<TransaccionContable>>(response);
    }
    return DataFailed<List<TransaccionContable>>(httpResponse.error!);
  }

  @override
  Future<DataState<TransaccionContable>> setTransaccionContableService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _transaccionContableDB.setTransaccionContableDB(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = httpResponse.data[0];
      final TransaccionContable response = TransaccionContableModel.fromDB(dataJson);
      return DataSuccess<TransaccionContable>(response);
    }
    return DataFailed<TransaccionContable>(httpResponse.error!);
  }

  @override
  Future<DataState<TransaccionContable>> updateTransaccionContableService(TransaccionContableRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _transaccionContableDB.updateTransaccionContableDB(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = (httpResponse.data as List<dynamic>).first;
      final TransaccionContable response = TransaccionContableModel.fromDB(dataJson);
      return DataSuccess<TransaccionContable>(response);
    }
    return DataFailed<TransaccionContable>(httpResponse.error!);
  }

  @override
  Future<DataState<List<TransaccionContableTipoImpuesto>>> getTipoImpuestosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _transaccionContableDB.getTipoImpuestosDB());

    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;
      final List<TransaccionContableTipoImpuesto> response =
          List<TransaccionContableTipoImpuesto>.from(resp.map((dynamic x) => TransaccionContableTipoImpuestoModel.fromDB(x)));
      return DataSuccess<List<TransaccionContableTipoImpuesto>>(response);
    }
    return DataFailed<List<TransaccionContableTipoImpuesto>>(httpResponse.error!);
  }
}
