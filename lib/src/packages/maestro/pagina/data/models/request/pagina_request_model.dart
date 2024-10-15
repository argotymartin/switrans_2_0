import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';

class PaginaRequestModel extends PaginaRequest {
  PaginaRequestModel({
    required super.codigo,
    required super.nombre,
    required super.path,
    required super.modulo,
    required super.isVisible,
    required super.isActivo,
  });

  factory PaginaRequestModel.fromMap(Map<String, dynamic> map) => PaginaRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        path: map['path'],
        modulo: map['modulo'],
        isVisible: map['isVisible'],
        isActivo: map['isActivo'],
      );
}
