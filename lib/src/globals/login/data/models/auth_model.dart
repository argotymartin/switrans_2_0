import 'package:switrans_2_0/src/globals/login/data/models/usuario_model.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/util/resources/pocketbase/pocketbase_response.dart';

class AuthModel extends Auth {
  AuthModel({required super.usuario, required super.token});

  factory AuthModel.fromPocketbase(PocketBaseResponse response) => AuthModel(
        usuario: UsuarioModel.fromJson(response.record),
        token: response.token,
      );
}
