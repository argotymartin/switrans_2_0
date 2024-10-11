import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractTipoImpuestoRepository {
  Future<DataState<List<TipoImpuesto>>> getTipoImpuestosService(TipoImpuestoRequest request);
  Future<DataState<TipoImpuesto>> setTipoImpuestoService(TipoImpuestoRequest request);
  Future<DataState<TipoImpuesto>> updateTipoImpuestoService(EntityUpdate<TipoImpuestoRequest> request);
}
