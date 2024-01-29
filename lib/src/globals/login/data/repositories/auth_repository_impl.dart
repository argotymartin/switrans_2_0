import 'package:switrans_2_0/src/globals/login/data/datasources/api/auth_pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/login/data/models/auth_model.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/login/domain/repositories/abstract_auth_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/resources/pocketbase/pocketbase_response.dart';

class AuthRepositoryImpl extends BaseApiRepository implements AbstractAuthRepository {
  final AuthPocketbaseApi _api;

  AuthRepositoryImpl(this._api);
  @override
  Future<DataState<Auth>> signin(UsuarioRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.getinfoUser(request));
    if (httpResponse.data != null) {
      final PocketBaseResponse response = PocketBaseResponse.fromJson(httpResponse.data);
      final resp = AuthModel.fromPocketbase(response);
      return DataSuccess(resp);
    } else {
      return DataFailed(httpResponse.error!);
    }
  }

  @override
  Future<bool> validateToken(UsuarioRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.refreshToken(request));
    if (httpResponse.data != null) {
      return true;
    } else {
      return false;
    }
  }
}
