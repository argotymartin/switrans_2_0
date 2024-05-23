import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';

class PaginaRequestModel extends PaginaRequest {
  PaginaRequestModel({
    required super.paginaCodigo,
    required super.paginaNombre,
    required super.paginaPath,
    required super.paginaVisible,
    required super.paginaActivo,
  });

  Map<String, dynamic> toJsonCreate() {
    return <String, dynamic>{
      'pagina_codigo': paginaCodigo,
      'pagina_texto': paginaNombre,
      'pagina_path': paginaPath,
      'pagina_visible': paginaVisible,
      'pagina_activo': paginaActivo,
    };
  }

  factory PaginaRequestModel.fromMapTable(Map<String, dynamic> map) => PaginaRequestModel(
        paginaCodigo: map['codigo'],
        paginaNombre: map['nombre'],
        paginaPath: map['path'],
        paginaVisible: map['visible'],
        paginaActivo: map['activo'],
      );
}
