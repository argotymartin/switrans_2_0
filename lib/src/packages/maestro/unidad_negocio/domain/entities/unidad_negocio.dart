class UnidadNegocio {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final String fechaCreacion;
  final int? codigoUsuario;
  final String nombreUsuario;
  final String? nombreEmpresa;
  final int empresa;

  UnidadNegocio({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.fechaCreacion,
    required this.codigoUsuario,
    required this.nombreUsuario,
    required this.nombreEmpresa,
    required this.empresa,
  });
}
