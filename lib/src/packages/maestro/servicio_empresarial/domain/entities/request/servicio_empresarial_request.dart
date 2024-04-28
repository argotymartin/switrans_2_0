class ServicioEmpresarialRequest {
  final int? codigo;
  final String? nombre;
  final int? usuario;
  final bool? esActivo;

  ServicioEmpresarialRequest({
    this.codigo,
    this.nombre,
    this.usuario,
    this.esActivo,
  });

  factory ServicioEmpresarialRequest.fromMapTable(Map<String, dynamic> map) => ServicioEmpresarialRequest(
        codigo: map['codigo'],
        nombre: map['nombre'],
        esActivo: map['activo'],
      );
}
