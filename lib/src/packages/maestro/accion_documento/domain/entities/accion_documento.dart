class AccionDocumento {
  final int codigo;
  final String nombre;
  final String tipoNombre;
  final int tipoCodigo;
  final bool isActivo;
  final bool isInverso;
  final String usuario;
  final String fechaCreacion;
  final String fechaActualizacion;
  AccionDocumento({
    required this.codigo,
    required this.nombre,
    required this.tipoNombre,
    required this.tipoCodigo,
    required this.isActivo,
    required this.isInverso,
    required this.usuario,
    required this.fechaCreacion,
    required this.fechaActualizacion,
  });
}
