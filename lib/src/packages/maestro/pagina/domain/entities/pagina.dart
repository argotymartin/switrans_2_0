class Pagina {
  String paginaId;
  int paginaCodigo;
  String paginaNombre;
  String paginaPath;
  bool paginaVisible;
  bool paginaActivo;
  String fechaCreacion;

  Pagina({
    required this.paginaId,
    required this.paginaCodigo,
    required this.paginaNombre,
    required this.paginaPath,
    required this.paginaVisible,
    required this.paginaActivo,
    required this.fechaCreacion,
  });
}
