import 'package:switrans_2_0/src/modules/views/factura/data/datasorces/api/cliente_pocketbase_api.dart';
import 'package:switrans_2_0/src/modules/views/factura/data/models/cliente_model.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/repositories/abstract_cliente_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class ClienteRepositoryImpl extends BaseApiRepository implements AbstractClienteRepository {
  final ClientePocketbaseAPI _api;

  ClienteRepositoryImpl(this._api);
  @override
  Future<DataState<List<Cliente>>> getClientes() async {
    final httpResponse = await getStateOf(request: () => _api.getClienteAll());
    if (httpResponse.data != null) {
      final List<dynamic> items = httpResponse.data['items'];
      final List<Cliente> response = items.cast<Map<String, dynamic>>().map((x) => ClienteModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<List<Cliente>>> getCliente(String param) async {
    final httpResponse = await getStateOf(request: () => _api.getCliente(param));
    if (httpResponse.data != null) {
      final List<dynamic> items = httpResponse.data['items'];
      final List<Cliente> response = items.cast<Map<String, dynamic>>().map((x) => ClienteModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }
}
