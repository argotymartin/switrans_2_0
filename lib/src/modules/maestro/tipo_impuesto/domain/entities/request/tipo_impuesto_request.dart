class TipoImpuestoRequest {
  final int? codigo;
  final int usuario;
  final String nombre;

  TipoImpuestoRequest({
    required this.nombre,
    required this.usuario,
    this.codigo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'usuario': usuario,
      'nombre': nombre,
    };
    if (codigo != 0) data['codigo'] = codigo;

    return data;
  }
}
