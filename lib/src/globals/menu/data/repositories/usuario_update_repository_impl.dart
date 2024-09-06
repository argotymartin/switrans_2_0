import 'package:switrans_2_0/src/globals/menu/data/datasources/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/usuario_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_usuario_update_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class UsuarioUpdateRepositoryImpl extends BaseApiRepository implements AbstractUsuarioUpdateRepository {
  final PocketbaseAPI _api;

  UsuarioUpdateRepositoryImpl(this._api);
  @override
  Future<DataState<Usuario>> updateUsuario(UsuarioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateUsuario(request));
    if (httpResponse.data != null) {
      final dynamic items = httpResponse.data;
      final Usuario response = UsuarioModel.fromJson(items);
      return DataSuccess<Usuario>(response);
    }
    return DataFailed<Usuario>(httpResponse.error!);
  }
}
