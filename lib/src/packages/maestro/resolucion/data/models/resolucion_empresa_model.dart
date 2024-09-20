import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';

class ResolucionEmpresaModel extends ResolucionEmpresa {
  ResolucionEmpresaModel({
    required super.codigo,
    required super.nombre,
    required super.nit,
  });

  factory ResolucionEmpresaModel.fromDB(Map<String, dynamic> map) => ResolucionEmpresaModel(
        codigo: map['codigo'],
        nombre: map['empresa'],
        nit: map['nit'],
      );
}
