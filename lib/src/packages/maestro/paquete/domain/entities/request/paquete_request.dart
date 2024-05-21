class PaqueteRequest {
  late int? paqueteCodigo;
  final String? paqueteNombre;
  late String? paquetePath;
  final bool? paqueteVisible;
  final bool? paqueteActivo;
  final String? paqueteIcono;

  PaqueteRequest({
    this.paqueteCodigo,
    this.paqueteNombre,
    this.paquetePath,
    this.paqueteVisible,
    this.paqueteActivo,
    this.paqueteIcono,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': paqueteCodigo,
      'nombre': paqueteNombre,
      'path': paquetePath,
      'visible': paqueteVisible,
      'icono': paqueteIcono,
    };
  }

}
