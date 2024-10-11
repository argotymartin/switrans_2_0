import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractTransaccionContableRepository {
  Future<DataState<List<TransaccionContable>>> getTransaccionContablesService(TransaccionContableRequest request);
  Future<DataState<TransaccionContable>> setTransaccionContableService(TransaccionContableRequest request);
  Future<DataState<TransaccionContable>> updateTransaccionContableService(EntityUpdate<TransaccionContableRequest> request);
  Future<DataState<List<TransaccionContableTipoImpuesto>>> getTipoImpuestosService();
}
