import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';

class PaqueteModel extends Paquete {
  PaqueteModel({
    required super.paqueteId,
    required super.paqueteCodigo,
    required super.paqueteNombre,
    required super.paquetePath,
    required super.paqueteVisible,
    required super.paqueteActivo,
    required super.paqueteIcono,
    required super.fechaCreacion,
  });

  factory PaqueteModel.fromJson(Map<String, dynamic> json) => PaqueteModel(
        paqueteId: json["id"],
        paqueteCodigo: json["codigo"],
        paqueteNombre: json["nombre"],
        paquetePath: json["path"],
        paqueteVisible: json["visible"],
        paqueteActivo: json["activo"],
        paqueteIcono: json["icono"],
        fechaCreacion: json["created"].toString(),
      );
}
