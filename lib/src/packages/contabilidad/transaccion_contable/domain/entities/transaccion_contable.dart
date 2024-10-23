class TransaccionContable {
  final int codigo;
  final String nombre;
  final String sigla;
  final bool isActivo;
  final int orden;
  final String fechaCreacion;
  final int tipoimpuesto;
  final int? codigoUsuario;
  final String nombreUsuario;

  TransaccionContable({
    required this.codigo,
    required this.nombre,
    required this.sigla,
    required this.isActivo,
    required this.orden,
    required this.fechaCreacion,
    required this.tipoimpuesto,
    required this.nombreUsuario,
    this.codigoUsuario,
  });
}
