
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';

class PaginaRequestModel extends PaginaRequest {

  PaginaRequestModel({ required super.paginaId, required super.paginaCodigo, required super.paginaTexto, required super.paginaPath, required super.paginaVisible, required super.moduloId, required super.paginaActivo, });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': '$paginaId',
      'pagina_codigo': paginaCodigo,
      'pagina_texto': "$paginaTexto",
      'pagina_path': '$paginaPath',
      'pagina_visible': paginaVisible,
      'modulo': moduloId,
      'pagina_activo': paginaActivo,
    };
    if (paginaId != '0') {
      data['id'] = '$paginaId';
    }
    if (paginaCodigo != 0) {
      data['pagina_codigo'] = paginaCodigo;
    }
    if (paginaTexto!.isEmpty) {
      data['pagina_nombre'] = '$paginaTexto';
    }
    if (paginaPath!.isEmpty) {
      data['pagina_path'] = '$paginaPath';
    }
    if (paginaVisible != null) {
      data['pagina_visible'] = paginaVisible;
    }
    if (moduloId!.isEmpty) {
      data['modulo'] = moduloId;
    }
    if (paginaActivo != null) {
      data['pagina_activo'] = paginaActivo;
    }
    return data;
  }

  Map<String, dynamic> toJsonCreate() {
    return <String, dynamic>{
      'pagina_codigo': paginaCodigo,
      'pagina_texto': paginaTexto,
      'pagina_path': paginaPath,
      'pagina_visible': paginaVisible,
      'modulo': moduloId,
      'pagina_activo': paginaActivo,
    };
  }


  factory PaginaRequestModel.fromMap(Map<String, dynamic> map) => PaginaRequestModel(
    paginaId: map['id'],
    paginaCodigo: map['codigo'],
    paginaTexto: map['nombre'],
    paginaPath: map['path'],
    paginaVisible: map['visible'],
    moduloId: map['modulo'],
    paginaActivo: map['activo'],
  );




}