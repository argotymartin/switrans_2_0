class Departamento {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final String? codigoDane;
  final String fechaCreacion;
  final int? codigoUsuario;
  final int pais;

  Departamento({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.fechaCreacion,
    required this.pais,
    this.codigoDane,
    this.codigoUsuario,
  });
}
