import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';

class ModuloModel extends Modulo {
  ModuloModel({
    required super.codigo,
    required super.nombre,
    required super.detalles,
    required super.path,
    required super.isVisible,
    required super.icono,
    required super.paquete,
    required super.isActivo,
    required super.fechaCreacion,
  });

  factory ModuloModel.fromJsonPB(Map<String, dynamic> json) => ModuloModel(
        codigo: json["modulo_codigo"],
        nombre: json["modulo_nombre"],
        detalles: json["modulo_detalles"],
        path: json["modulo_path"],
        isVisible: json["modulo_visible"],
        icono: json["modulo_icono"],
        paquete: json["expand"]["paquete"]["codigo"],
        isActivo: json["modulo_activo"],
        fechaCreacion: json["created"].toString(),
      );
}
