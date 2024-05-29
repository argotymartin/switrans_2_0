class PaginaRequest {
  final String? id;
  int? codigo;
  final String? nombre;
  final String? path;
  late String? modulo;
  final bool? isVisible;
  final bool? isActivo;

  PaginaRequest({
    this.id,
    this.codigo,
    this.nombre,
    this.path,
    this.modulo,
    this.isVisible,
    this.isActivo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'pagina_codigo': codigo,
      'pagina_texto': nombre,
      'pagina_path': path,
      'modulo': modulo,
      'pagina_visible': isVisible,
      'pagina_activo': isActivo,
    };
  }
}
