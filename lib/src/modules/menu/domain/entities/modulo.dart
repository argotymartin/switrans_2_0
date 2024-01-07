import 'package:switrans_2_0/src/modules/menu/domain/entities/pagina.dart';

class Modulo {
  final int moduloCodigo;
  final String moduloIcono;
  final String moduloTexto;
  final bool moduloVisible;
  final List<Pagina> paginas;
  bool isSelected;

  Modulo(
      {required this.moduloCodigo,
      required this.moduloIcono,
      required this.moduloTexto,
      required this.moduloVisible,
      this.paginas = const [],
      this.isSelected = false});
}
