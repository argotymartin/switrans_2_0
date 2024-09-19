class Departamento {
  final int codigo;
  final String nombre;
  final int codigoUsuario;
  final String? codigoDane;
  final int pais;
  final bool isActivo;
  final String fechaCreacion;

  Departamento({
    required this.codigo,
    required this.nombre,
    required this.codigoUsuario,
    this.codigoDane,
    required this.pais,
    required this.isActivo,
    required this.fechaCreacion,
  });
}
