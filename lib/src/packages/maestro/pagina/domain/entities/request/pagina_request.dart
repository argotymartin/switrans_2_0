class PaginaRequest {
  int? codigo;
  final String? nombre;
  final String? path;
  int ? modulo;
  final bool? isVisible;
  final bool? isActivo;

  PaginaRequest({
    this.codigo,
    this.nombre,
    this.path,
    this.modulo,
    this.isVisible,
    this.isActivo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'path': path,
      'modulo': modulo,
      'isActivo': isActivo,
      'isVisible': isVisible,
    };
  }
}

