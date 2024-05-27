import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina_modulo.dart';

class PaginaModuloModel extends PaginaModulo {

  PaginaModuloModel({required super.moduloId, required super.codigo, required super.nombre});

  factory PaginaModuloModel.fromJson(Map<String, dynamic> json) => PaginaModuloModel(
    moduloId: json['id'],
    codigo: json['modulo_codigo'],
    nombre: json['modulo_nombre'],
  );
}
