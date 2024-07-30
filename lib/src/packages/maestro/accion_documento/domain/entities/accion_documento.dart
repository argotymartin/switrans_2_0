class AccionDocumento {
  final int codigo;
  final String nombre;
  final String tipoNombre;
  final int tipoCodigo;
  final bool esActivo;
  final bool esInverso;
  final String usuario;
  final String fechaCreacion;
  final String fechaActualizacion;
  AccionDocumento({
    required this.codigo,
    required this.nombre,
    required this.tipoNombre,
    required this.tipoCodigo,
    required this.esActivo,
    required this.esInverso,
    required this.usuario,
    required this.fechaCreacion,
    required this.fechaActualizacion,
  });
}
