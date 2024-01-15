import 'package:switrans_2_0/src/modules/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/modules/login/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractUsuarioRepository {
  Future<DataState<Usuario>> getUsuario(UsuarioRequest request);
}
