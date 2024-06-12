import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractTransaccionContableRepository {
  Future<DataState<List<TransaccionContable>>> getTransaccionesContablesService(TransaccionContableRequest request);
  Future<DataState<TransaccionContable>> createTransaccionesContablesService(TransaccionContableRequest request);
  Future<DataState<TransaccionContable>> updateTransaccionesContablesService(TransaccionContableRequest request);
  Future<DataState<List<TransaccionContableTipoImpuesto>>> getImpuestosService();

}
