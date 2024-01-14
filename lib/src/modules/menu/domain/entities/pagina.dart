class Pagina {
  final String id;
  final String modulo;
  final int paginaCodigo;
  final String paginaTexto;
  bool isSelected;

  Pagina({
    required this.id,
    required this.modulo,
    required this.paginaCodigo,
    required this.paginaTexto,
    this.isSelected = false,
  });
}
