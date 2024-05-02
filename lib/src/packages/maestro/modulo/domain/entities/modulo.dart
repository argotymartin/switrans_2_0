class Modulo {
   String moduloId;
   int moduloCodigo;
   String moduloNombre;
   String moduloDetalles;
   String moduloPath;
   bool moduloVisible;
   String moduloIcono;
   String paquete;
   bool moduloActivo;
   String fechaCreacion;

  Modulo({
    required this.moduloId,
    required this.moduloCodigo,
    required this.moduloNombre,
    required this.moduloDetalles,
    required this.moduloPath,
    required this.moduloVisible,
    required this.moduloIcono,
    required this.paquete,
    required this.moduloActivo,
    required this.fechaCreacion
  });
}