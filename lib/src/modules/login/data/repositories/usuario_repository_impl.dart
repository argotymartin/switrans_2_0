import 'package:switrans_2_0/src/modules/login/data/datasources/api/usuario_pocketbase_api.dart';
import 'package:switrans_2_0/src/modules/login/data/models/usuario_model.dart';
import 'package:switrans_2_0/src/modules/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/modules/login/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/modules/login/domain/repositories/abstract_usuario_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/resources/pocketbase/pocketbase_response.dart';

class UsuarioRepositoryImpl extends BaseApiRepository implements AbstractUsuarioRepository {
  final UsuarioPocketbaseApi _api;

  UsuarioRepositoryImpl(this._api);
  @override
  Future<DataState<Usuario>> getUsuario(UsuarioRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.getinfoUser(request));
    if (httpResponse.data != null) {
      final PocketBaseResponse response = PocketBaseResponse.fromJson(httpResponse.data);
      final resp = UsuarioModel.fromJson(response.record);
      return DataSuccess(resp);
    } else {
      return DataFailed(httpResponse.error!);
    }
  }
}
