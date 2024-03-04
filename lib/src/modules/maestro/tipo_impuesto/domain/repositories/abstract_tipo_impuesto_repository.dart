import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractTipoImpuestoRepository {
  Future<DataState<List<TipoImpuesto>>> getTipoImpuestosService();
  Future<DataState<TipoImpuesto>> setTipoImpuestoService(TipoImpuestoRequest request);
}
