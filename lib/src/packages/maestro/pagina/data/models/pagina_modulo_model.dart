import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';

class PaginaModuloModel extends PaginaModulo {
  PaginaModuloModel({required super.codigo, required super.nombre});

  factory PaginaModuloModel.fromJson(Map<String, dynamic> json) => PaginaModuloModel(
        codigo: json['modulo_codigo'],
        nombre: json['modulo_nombre'],
      );
}
