class Paquete {
  String paqueteId;
  int paqueteCodigo;
  String paqueteNombre;
  String paquetePath;
  bool paqueteVisible;
  bool paqueteActivo;
  String paqueteIcono;
  String fechaCreacion;

  Paquete({
    required this.paqueteId,
    required this.paqueteCodigo,
    required this.paqueteNombre,
    required this.paquetePath,
    required this.paqueteVisible,
    required this.paqueteActivo,
    required this.paqueteIcono,
    required this.fechaCreacion,
  });
}
