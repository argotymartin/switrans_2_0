class Pagina {
  String id;
  int paginaCodigo;
  String paginaTexto;
  String paginaPath;
  bool paginaVisible;
  bool paginaActivo;
  String fechaCreacion;

  Pagina({
    required this.id,
    required this.paginaCodigo,
    required this.paginaTexto,
    required this.paginaPath,
    required this.paginaVisible,
    required this.paginaActivo,
    required this.fechaCreacion,
  });
}
