import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina.dart';

class Modulo {
  final int codigo;
  final String icono;
  final String texto;
  final String path;
  List<Pagina> paginas;
  bool isSelected;

  Modulo({
    required this.codigo,
    required this.icono,
    required this.texto,
    required this.path,
    this.paginas = const [],
    this.isSelected = false,
  });
}
