import 'package:switrans_2_0/src/modules/menu/data/datasorces/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/modules/menu/data/models/modulo_model.dart';
import 'package:switrans_2_0/src/modules/menu/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/modules/menu/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class ModuloRespositoryImpl extends BaseApiRepository implements AbstractModuloRepository {
  final PocketbaseAPI _api;

  ModuloRespositoryImpl(this._api);
  @override
  Future<DataState<List<Modulo>>> getModulos() async {
    final httpResponse = await getStateOf(request: () => _api.getModulosAll());
    if (httpResponse.data != null) {
      final List<dynamic> items = httpResponse.data['items'];
      final List<ModuloModel> response = items.cast<Map<String, dynamic>>().map((x) => ModuloModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }
}
