import 'package:switrans_2_0/src/modules/login/domain/entities/usuario.dart';

class Auth {
  final Usuario usuario;
  final String token;

  Auth({
    required this.usuario,
    required this.token,
  });
}
