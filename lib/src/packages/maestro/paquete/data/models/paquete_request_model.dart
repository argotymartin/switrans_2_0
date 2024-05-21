import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';

class PaqueteRequestModel extends PaqueteRequest {
  PaqueteRequestModel({
    required super.paqueteCodigo,
    required super.paqueteNombre,
    required super.paquetePath,
    required super.paqueteVisible,
    required super.paqueteActivo,
    required super.paqueteIcono,
  });

  /*Map<String, dynamic> toJsonPocketBase() {
    final Map<String, dynamic> data = <String, dynamic>{
      'codigo': paqueteCodigo,
      'nombre': "$paqueteNombre",
      'path': '$paquetePath',
      'visible': paqueteVisible,
      'activo': paqueteActivo,
      'icono': '$paqueteIcono',
    };

    if (paqueteCodigo != 0) {
      data['codigo'] = paqueteCodigo;
    }
    if (paqueteNombre!.isEmpty) {
      data['nombre'] = '$paqueteNombre';
    }
    if (paquetePath!.isEmpty) {
      data['path'] = '$paquetePath';
    }
    data['visible'] = paqueteVisible;
    data['activo'] = paqueteActivo;
    if (paqueteIcono!.isEmpty) {
      data['icono'] = '$paqueteIcono';
    }
    return data;
  }*/

  Map<String, dynamic> toJsonCreate() {
    return <String, dynamic>{
      'codigo': paqueteCodigo,
      'nombre': paqueteNombre,
      'path': paquetePath,
      'visible': paqueteVisible,
      'icono': paqueteIcono,
    };
  }

  factory PaqueteRequestModel.fromMap(Map<String, dynamic> map) => PaqueteRequestModel(
    paqueteCodigo: map['codigo'],
    paqueteNombre: map['nombre'],
    paquetePath: map['path'],
    paqueteVisible: map['visible'],
    paqueteActivo: map['activo'],
    paqueteIcono: map['icono'],
  );
}
