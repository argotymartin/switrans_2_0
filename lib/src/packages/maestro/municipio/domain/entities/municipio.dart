class Municipio {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final String fechaCreacion;
  final double? latitud;
  final double? longitud;
  final int codigoDepartamento;
  final String nombreDepartamento;
  final int? codigoUsuario;
  final String nombreUsuario;
  final String? codigoDane;
  final int? codigoPais;
  final String? nombrePais;

  Municipio({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.fechaCreacion,
    required this.codigoDepartamento,
    required this.nombreDepartamento,
    required this.nombreUsuario,
    this.latitud,
    this.longitud,
    this.codigoUsuario,
    this.codigoDane,
    this.codigoPais,
    this.nombrePais,
  });
}
