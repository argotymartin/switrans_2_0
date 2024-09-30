import 'package:switrans_2_0/src/packages/maestro/pais/domain/domain.dart';

class PaisModel extends Pais {
  PaisModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.usuarioNombre,
  });

  factory PaisModel.fromApi(Map<String, dynamic> map) => PaisModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        isActivo: map['estado'],
        fechaCreacion: map['fechaCreacion'].toString(),
        codigoUsuario: map['codigoUsuario'],
        usuarioNombre: map['usuarioNombre'],
      );
}
