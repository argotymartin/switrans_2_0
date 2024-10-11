import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';

class PaqueteRequestModel extends PaqueteRequest {
  PaqueteRequestModel({
    required super.codigo,
    required super.nombre,
    required super.path,
    required super.isVisible,
    required super.isActivo,
    required super.icono,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'path': path,
      'visible': isVisible,
      'activo': isActivo,
      'icono': icono,
    };
  }

  factory PaqueteRequestModel.fromMap(Map<String, dynamic> map) => PaqueteRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        path: map['path'],
        isVisible: map['visible'],
        isActivo: map['activo'],
        icono: map['icono'],
      );
}
