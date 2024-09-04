import 'package:switrans_2_0/src/globals/menu/domain/entities/pagina_menu.dart';

class ModuloMenu {
  final int codigo;
  final String icono;
  final String texto;
  final String paquete;
  final String path;
  final String detalles;
  List<PaginaMenu> paginas;

  ModuloMenu({
    required this.codigo,
    required this.icono,
    required this.texto,
    required this.paquete,
    required this.path,
    this.detalles = "",
    this.paginas = const <PaginaMenu>[],
  });
}
