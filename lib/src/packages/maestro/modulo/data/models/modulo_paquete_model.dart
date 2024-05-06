import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';

class ModuloPaqueteModel extends ModuloPaquete {
  ModuloPaqueteModel({
    required super.paqueteId,
    required super.codigo,
    required super.nombre,
    required super.icono,
    required super.visible,
    required super.path,
  });

  factory ModuloPaqueteModel.fromJson(Map<String, dynamic> json) => ModuloPaqueteModel(
    paqueteId: json['id'],
    codigo: json['codigo'],
    nombre: json['nombre'],
    icono: json['icono'],
    visible: json['visible'],
    path: json['path'],
  );

}
