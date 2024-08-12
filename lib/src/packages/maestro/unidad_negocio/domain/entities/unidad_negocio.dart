class UnidadNegocio {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final String fechaCreacion;
  final String usuario;
  final int? empresa;

  UnidadNegocio({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.fechaCreacion,
    required this.usuario,
    required this.empresa,
  });
}
