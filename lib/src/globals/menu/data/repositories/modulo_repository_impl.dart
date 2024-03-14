import 'package:switrans_2_0/src/globals/menu/data/datasorces/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class ModuloRespositoryImpl extends BaseApiRepository implements AbstractModuloRepository {
  final PocketbaseAPI _api;

  ModuloRespositoryImpl(this._api);
  @override
  Future<DataState<List<Paquete>>> getModulos() async {
    final httpResponse = await getStateOf(request: () => _api.getModulosAll());
    if (httpResponse.data != null) {
      final List<dynamic> items = httpResponse.data['items'];
      final List<Paquete> response = items.cast<Map<String, dynamic>>().map((x) => PaqueteModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }
}
