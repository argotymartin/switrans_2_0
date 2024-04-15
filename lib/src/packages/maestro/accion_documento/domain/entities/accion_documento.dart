class AccionDocumento {
  final int codigo;
  final String nombre;
  final String tipo;
  final bool esActivo;
  final bool esInverso;
  final String usuario;
  final String fechaCreacion;
  AccionDocumento({
    required this.codigo,
    required this.nombre,
    required this.tipo,
    required this.esActivo,
    required this.esInverso,
    required this.usuario,
    required this.fechaCreacion,
  });
}
