class PaginaRequest {
  late int? paginaCodigo;
  final String? paginaTexto;
  late String? paginaPath;
  final bool? paginaVisible;
  final bool? paginaActivo;
  PaginaRequest({
    this.paginaCodigo,
    this.paginaTexto,
    this.paginaPath,
    this.paginaVisible,
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
