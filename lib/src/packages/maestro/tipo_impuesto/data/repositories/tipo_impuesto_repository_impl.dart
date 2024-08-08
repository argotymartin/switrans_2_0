import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/datasources/api/tipo_impuesto_api.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/models/tipo_impuesto_model.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/request/tipo_impuesto_request.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/entities/tipo_impuesto.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/repositories/abstract_tipo_impuesto_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class TipoImpuestoRepositoryImpl extends BaseApiRepository implements AbstractTipoImpuestoRepository {
  final TipoImpuestoApi _api;
  TipoImpuestoRepositoryImpl(this._api);
  @override
  Future<DataState<List<TipoImpuesto>>> getTipoImpuestosService(TipoImpuestoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTipoImpuestosApi(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data["items"];
      final List<TipoImpuesto> response = List<TipoImpuesto>.from(resp.map((dynamic x) => TipoImpuestoModel.fromJson(x)));
      return DataSuccess<List<TipoImpuesto>>(response);
    }
    return DataFailed<List<TipoImpuesto>>(httpResponse.error!);
  }

  @override
  Future<DataState<TipoImpuesto>> setTipoImpuestoService(TipoImpuestoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setTipoImpuestoApi(request));
    if (httpResponse.data != null) {
      final TipoImpuesto response = TipoImpuestoModel.fromJson(httpResponse.data);
      return DataSuccess<TipoImpuesto>(response);
    }
    return DataFailed<TipoImpuesto>(httpResponse.error!);
  }

  @override
  Future<DataState<TipoImpuesto>> updateTipoImpuestoService(TipoImpuestoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateTipoImpuestoApi(request));
    if (httpResponse.data != null) {
      final TipoImpuesto response = TipoImpuestoModel.fromJson(httpResponse.data);
      return DataSuccess<TipoImpuesto>(response);
    }
    return DataFailed<TipoImpuesto>(httpResponse.error!);
  }
}
