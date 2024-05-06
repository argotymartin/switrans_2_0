 import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio_empresa.dart';

class UnidadNegocioEmpresaModel extends UnidadNegocioEmpresa{
  UnidadNegocioEmpresaModel({
    required super.codigo,
    required super.nombre
  });

  factory UnidadNegocioEmpresaModel.fromDB(Map<String, dynamic> json) => UnidadNegocioEmpresaModel(
    codigo: json['empresa_codigo'],
    nombre: json['empresa_nombre']
  );
 }