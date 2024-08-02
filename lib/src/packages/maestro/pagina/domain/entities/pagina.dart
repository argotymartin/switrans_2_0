class Pagina {
  final int codigo;
  final String texto;
  final String path;
  final bool isVisible;
  final bool isActivo;
  final int modulo;
  final String fechaCreacion;

  Pagina({
    required this.codigo,
    required this.texto,
    required this.path,
    required this.isVisible,
    required this.isActivo,
    required this.modulo,
    required this.fechaCreacion,
  });
}
