class Pagina {
  int paginaCodigo;
  String paginaTexto;
  String paginaPath;
  bool paginaVisible;
  bool paginaActivo;
  int modulo;
  String fechaCreacion;

  Pagina({
    required this.paginaCodigo,
    required this.paginaTexto,
    required this.paginaPath,
    required this.paginaVisible,
    required this.paginaActivo,
    required this.modulo,
    required this.fechaCreacion,
  });
}
