import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    required super.id,
    required super.avatar,
    required super.codigo,
    required super.login,
    required super.nombre,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        avatar: '$kPocketBaseUrl/api/files/users/${json["id"]}/${json["avatar"]}',
        codigo: json["codigo_switrans"] ?? 2384,
        login: json["username"],
        nombre: json["name"],
      );
}
