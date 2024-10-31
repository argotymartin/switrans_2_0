class AccionDocumento {
  final int codigo;
  final String nombre;
  final bool isActivo;
  final bool isInverso;
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
    required this.isInverso,
    required this.isReversible,
    required this.fechaCreacion,
    required this.codigoUsuario,
    required this.nombreUsuario,
    required this.codigoDocumento,
    required this.nombreDocumento,
  });
}
