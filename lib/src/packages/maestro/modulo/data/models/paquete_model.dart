import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/paquete.dart';

class PaqueteModel extends Paquete {
  PaqueteModel({
    required super.paqueteId,
    required super.codigo,
    required super.nombre,
    required super.icono,
    required super.visible,
    required super.path,
  });

  factory PaqueteModel.fromJson(Map<String, dynamic> json) => PaqueteModel(
    paqueteId: json['id'],
    codigo: json['codigo'],
    nombre: json['nombre'],
    icono: json['icono'],
    visible: json['visible'],
    path: json['path'],
  );

}