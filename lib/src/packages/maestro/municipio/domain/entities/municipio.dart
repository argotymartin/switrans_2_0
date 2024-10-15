class Municipio {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final String fechaCreacion;
  final int departamento;
  final int? codigoUsuario;
  final String nombreUsuario;
  final String? codigoDane;

  Municipio({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.fechaCreacion,
    required this.departamento,
    required this.nombreUsuario,
    this.codigoUsuario,
    this.codigoDane,
  });
}
