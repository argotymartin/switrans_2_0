import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    required super.id,
    required super.rol,
    required super.avatar,
    required super.codigo,
    required super.login,
    required super.nombre,
    required super.phoneId,
    required super.telefonoContacto,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        rol: json["rol"],
        avatar: '$kPocketBaseUrl/api/files/usuario_nedimo/${json["id"]}/${json["avatar"]}',
        codigo: json["usunedCodigo"],
        login: json["usunedLogin"],
        nombre: json["usunedNombre"],
        phoneId: json["usunedPhoneId"],
        telefonoContacto: json["usunedTelefonoContacto"],
      );
}
