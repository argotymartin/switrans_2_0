import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';

class PaqueteModel extends Paquete {
  PaqueteModel({
    required super.codigo,
    required super.nombre,
    required super.path,
    required super.isVisible,
    required super.isActivo,
    required super.icono,
    required super.fechaCreacion,
  });

  factory PaqueteModel.fromJson(Map<String, dynamic> json) => PaqueteModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        path: json["path"],
        isVisible: json["visible"],
        isActivo: json["activo"],
        icono: json["icono"],
        fechaCreacion: json["created"].toString(),
      );
}
