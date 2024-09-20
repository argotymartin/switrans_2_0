class Resolucion {
  final int codigo;
  final String numero;
  final String fecha;
  final int rangoInicial;
  final int rangoFinal;
  final String fechaVigencia;
  final String empresaPrefijo;
  final String version;
  final bool isActiva;
  final int codigoDocumento;
  final String nombreDocumento;
  final int codigoEmpresa;
  final String nombreEmpresa;
  final int codigoUsuario;
  final String nombreUsuario;

  Resolucion({
    required this.codigo,
    required this.numero,
    required this.fecha,
    required this.rangoInicial,
    required this.rangoFinal,
    required this.fechaVigencia,
    required this.empresaPrefijo,
    required this.version,
    required this.isActiva,
    required this.codigoDocumento,
    required this.nombreDocumento,
    required this.codigoEmpresa,
    required this.nombreEmpresa,
    required this.codigoUsuario,
    required this.nombreUsuario,
  });
}
