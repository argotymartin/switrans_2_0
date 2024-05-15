class PaqueteRequest {
  final String? paqueteId;
  late int? paqueteCodigo;
  final String? paqueteNombre;
  late String? paquetePath;
  final bool? paqueteVisible;
  final String? paqueteIcono;

  PaqueteRequest({
    this.paqueteId,
    this.paqueteCodigo,
    this.paqueteNombre,
    this.paquetePath,
    this.paqueteVisible,
    this.paqueteIcono,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': '$paqueteId',
      'codigo': paqueteCodigo,
      'nombre': "$paqueteNombre",
      'path': '$paquetePath',
      'visible': paqueteVisible,
      'icono': '$paqueteIcono',
    };
    if (paqueteId != '0') {
      data['id'] = '$paqueteId';
    }
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
    if (paqueteIcono!.isEmpty) {
      data['icono'] = '$paqueteIcono';
    }
    return data;
  }

  Map<String, dynamic> toJsonCreate() {
    return <String, dynamic>{
      'codigo': paqueteCodigo,
      'nombre': paqueteNombre,
      'path': paquetePath,
      'visible': paqueteVisible,
      'icono': paqueteIcono,
    };
  }

  factory PaqueteRequest.fromMap(Map<String, dynamic> map) => PaqueteRequest(
        paqueteId: map['id'],
        paqueteCodigo: map['codigo'],
        paqueteNombre: map['nombre'],
        paquetePath: map['path'],
        paqueteVisible: map['visible'],
        paqueteIcono: map['icono'],
      );
}
