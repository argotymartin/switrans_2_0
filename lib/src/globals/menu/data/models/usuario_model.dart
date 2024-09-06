import 'package:switrans_2_0/src/config/constans/constants.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    required super.id,
    required super.codigo,
    required super.nombre,
    required super.avatar,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        codigo: json["usunedCodigo"],
        nombre: json["usunedNombre"],
        avatar: '$kPocketBaseUrl/api/files/usuario_nedimo/${json["id"]}/${json["avatar"]}',
      );
}
