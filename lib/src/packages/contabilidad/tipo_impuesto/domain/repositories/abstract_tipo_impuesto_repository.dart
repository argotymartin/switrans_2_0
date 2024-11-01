import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractTipoImpuestoRepository {
  Future<DataState<List<TipoImpuesto>>> getTipoImpuestosService(TipoImpuestoRequest request);
  Future<DataState<TipoImpuesto>> setTipoImpuestoService(TipoImpuestoRequest request);
  Future<DataState<TipoImpuesto>> updateTipoImpuestosService(EntityUpdate<TipoImpuestoRequest> request);
}
