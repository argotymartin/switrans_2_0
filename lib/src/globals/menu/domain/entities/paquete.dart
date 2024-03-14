import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo.dart';

class Paquete {
  final String id;
  final int codigo;
  final String nombre;
  final String icono;
  final String path;
  final bool visible;
  List<Modulo> modulos;
  bool isSelected;

  Paquete({
    required this.id,
    required this.nombre,
    required this.codigo,
    required this.icono,
    required this.path,
    required this.visible,
    required this.modulos,
    this.isSelected = false,
  });
}
