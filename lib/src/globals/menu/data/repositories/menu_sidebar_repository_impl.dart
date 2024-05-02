import 'package:switrans_2_0/src/globals/menu/data/datasources/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_menu_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_menu_sidebar_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class MenuSidebarRespositoryImpl extends BaseApiRepository implements AbstractMenuSidebarRepository {
  final PocketbaseAPI _api;

  MenuSidebarRespositoryImpl(this._api);
  @override
  Future<DataState<List<PaqueteMenu>>> getModulos() async {
    final httpResponse = await getStateOf(request: () => _api.getModulosAll());
    if (httpResponse.data != null) {
      final List<dynamic> items = httpResponse.data['items'];
      final List<PaqueteMenu> response = items.cast<Map<String, dynamic>>().map((x) => PaqueteMenuModel.fromJsonPocketBase(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }
}
