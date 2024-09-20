import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';

class ResolucionCentroCostoModel extends ResolucionCentroCosto {
  ResolucionCentroCostoModel({
    required super.codigo,
    required super.nombre,
  });

  factory ResolucionCentroCostoModel.fromDB(Map<String, dynamic> map) => ResolucionCentroCostoModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
      );
}
