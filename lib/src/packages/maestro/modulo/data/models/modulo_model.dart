import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';

class ModuloModel extends Modulo {
  ModuloModel({
    required super.moduloId,
    required super.moduloCodigo,
    required super.moduloNombre,
    required super.moduloDetalles,
    required super.moduloPath,
    required super.moduloVisible,
    required super.moduloIcono,
    required super.paquete,
    required super.moduloActivo,
    required super.fechaCreacion,
  });

  factory ModuloModel.fromJson(Map<String, dynamic> json) => ModuloModel(
    moduloId: json["id"],
    moduloCodigo: json["modulo_codigo"],
    moduloNombre: json["modulo_nombre"],
    moduloDetalles: json["modulo_detalles"],
    moduloPath: json["modulo_path"],
    moduloVisible: json["modulo_visible"],
    moduloIcono: json["modulo_icono"],
    paquete: json["paquete"],
    moduloActivo: json["modulo_activo"],
    fechaCreacion: json["created"].toString(),
  );
}
