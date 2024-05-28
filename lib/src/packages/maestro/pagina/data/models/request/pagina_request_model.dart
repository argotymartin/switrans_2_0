
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';

class PaginaRequestModel extends PaginaRequest {

  PaginaRequestModel({
    required super.codigo,
    required super.nombre,
    required super.path,
    required super.isVisible,
    required super.isActivo,
    required super.modulo,
  });

  factory PaginaRequestModel.fromTable(Map<String, dynamic> map) => PaginaRequestModel(
    codigo: map['codigo'],
    nombre: map['nombre'],
    path: map['path'],
    isVisible: map['visible'],
    isActivo: map['activo'],
    modulo: map['modulo'],

  );
}
