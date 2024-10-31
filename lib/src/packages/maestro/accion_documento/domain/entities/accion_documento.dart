class AccionDocumento {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final bool isInversa;
  final bool isReversible;
  final String fechaCreacion;
  final int codigoUsuario;
  final String nombreUsuario;
  final int codigoDocumento;
  final String nombreDocumento;

  AccionDocumento({
    required this.codigo,
    required this.nombre,
    required this.isActivo,
    required this.isInversa,
    required this.isReversible,
    required this.fechaCreacion,
    required this.codigoUsuario,
    required this.nombreUsuario,
    required this.codigoDocumento,
    required this.nombreDocumento,
  });
}
