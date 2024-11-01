class TipoImpuesto {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final String fechaCreacion;
  final int codigoUsuario;
  final String nombreUsuario;

  TipoImpuesto({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.fechaCreacion,
    required this.codigoUsuario,
    required this.nombreUsuario,
  });
}
