import 'package:switrans_2_0/src/globals/menu/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractUsuarioUpdateRepository {
  Future<DataState<Usuario>> updateUsuario(UsuarioRequest request);
}
