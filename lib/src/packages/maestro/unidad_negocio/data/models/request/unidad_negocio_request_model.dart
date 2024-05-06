import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';

class UnidadNegocioRequestModel extends UnidadNegocioRequest {
  UnidadNegocioRequestModel({
    required super.codigo,
    required super.empresa,
    required super.isActivo,
    required super.nombre,
  });

  factory UnidadNegocioRequestModel.fromMapTable(Map<String, dynamic> map) => UnidadNegocioRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        isActivo: map['activo'],
        empresa: map['empresa'],
      );
}
