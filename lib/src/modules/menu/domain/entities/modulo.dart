import 'package:switrans_2_0/src/modules/menu/domain/entities/pagina.dart';

class Modulo {
  final int moduloCodigo;
  final String moduloIcono;
  final String moduloTexto;
  final String moduloPath;
  List<Pagina> paginas;
  bool isSelected;

  Modulo({
    required this.moduloCodigo,
    required this.moduloIcono,
    required this.moduloTexto,
    required this.moduloPath,
    this.paginas = const [],
    this.isSelected = false,
  });
}
