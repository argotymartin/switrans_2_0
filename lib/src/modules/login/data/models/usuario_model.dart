import 'package:switrans_2_0/src/modules/login/domain/entities/usuario.dart';

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
        avatar: json["usunedAvatar"],
        codigo: json["usunedCodigo"],
        login: json["usunedLogin"],
        nombre: json["usunedNombre"],
        phoneId: json["usunedPhoneId"],
        telefonoContacto: json["usunedTelefonoContacto"],
      );
}
