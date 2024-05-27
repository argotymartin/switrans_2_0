class PaginaRequest {
  final String? paginaId;
  late int? paginaCodigo;
  final String? paginaTexto;
  late String? paginaPath;
  final bool? paginaVisible;
  late String? moduloId;
  final bool? paginaActivo;

  PaginaRequest({
    this.paginaId,
    this.paginaCodigo,
    this.paginaTexto,
    this.paginaPath,
    this.paginaVisible,
    this.moduloId,
    this.paginaActivo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pagina_codigo': paginaCodigo,
      'pagina_texto': paginaTexto,
      'pagina_path': paginaPath,
      'pagina_visible': paginaVisible,
      'pagina_activo': paginaActivo,
    };
  }
}

