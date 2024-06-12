class TransaccionContable {
  final int codigo;
  final String nombre;
  final String sigla;
  final bool isActivo;
  final String? tipoimpuesto;
  final String usuario;
  final int secuencia;
  final String fechaCreacion;

  TransaccionContable({
    required this.codigo,
    required this.nombre,
    required this.sigla,
    required this.isActivo,
    required this.tipoimpuesto,
    required this.usuario,
    required this.secuencia,
    required this.fechaCreacion,
  });
}
