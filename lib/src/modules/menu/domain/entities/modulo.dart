import 'package:switrans_2_0/src/modules/menu/domain/entities/pagina.dart';

class Modulo {
  final int moduloCodigo;
  final String moduloIcono;
  final String moduloTexto;
  final String moduloPath;
  final List<Pagina> paginas;

  Modulo({
    required this.moduloCodigo,
    required this.moduloIcono,
    required this.moduloTexto,
    required this.moduloPath,
    this.paginas = const [],
  });
}
