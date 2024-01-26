class Pagina {
  final String id;
  final String modulo;
  final int codigo;
  final String texto;
  final String path;
  bool isSelected;

  Pagina({
    required this.id,
    required this.modulo,
    required this.codigo,
    required this.texto,
    required this.path,
    this.isSelected = false,
  });
}
