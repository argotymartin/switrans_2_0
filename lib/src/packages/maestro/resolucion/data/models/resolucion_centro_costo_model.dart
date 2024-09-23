import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';

class ResolucionCentroCostoModel extends ResolucionCentroCosto {
  ResolucionCentroCostoModel({
    required super.codigo,
    required super.nombre,
  });

  factory ResolucionCentroCostoModel.fromApi(Map<String, dynamic> map) => ResolucionCentroCostoModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
      );
}
