import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';

class ModuloRequestModel extends ModuloRequest {
  ModuloRequestModel({
    super.codigo,
    super.nombre,
    super.detalle,
    super.path,
    super.isVisible,
    super.icono,
    super.paquete,
    super.isActivo,
  });

  factory ModuloRequestModel.fromMap(Map<String, dynamic> map) => ModuloRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        detalle: map['detalles'],
        path: map['path'],
        isVisible: map['isVisible'],
        icono: map['icono'],
        paquete: map["paquete"],
        isActivo: map['isActivo'],
      );
}
