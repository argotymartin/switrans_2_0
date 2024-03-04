import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/data/datasorces/api/tipo_impuesto_api.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/data/models/tipo_impuesto_model.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/domain/repositories/abstract_tipo_impuesto_repository.dart';
import 'package:switrans_2_0/src/util/resources/backend/backend_response.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class TipoImpuestoRepositoryImpl extends BaseApiRepository implements AbstractTipoImpuestoRepository {
  final TipoImpuestoApi _api;
  TipoImpuestoRepositoryImpl(this._api);
  @override
  Future<DataState<List<TipoImpuesto>>> getTipoImpuestosService() async {
    final httpResponse = await getStateOf(request: () => _api.getTipoImpuestosApi());
    if (httpResponse.data != null) {
      final resp = BackendResponse.fromJson(httpResponse.data);
      final List<TipoImpuesto> response = resp.data.cast<Map<String, dynamic>>().map((x) => TipoImpuestoModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<TipoImpuesto>> setTipoImpuestoService() {
    throw UnimplementedError();
  }
}
