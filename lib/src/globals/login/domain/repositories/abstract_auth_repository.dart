import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractAuthRepository {
  Future<DataState<Auth>> signin(UsuarioRequest request);
}
