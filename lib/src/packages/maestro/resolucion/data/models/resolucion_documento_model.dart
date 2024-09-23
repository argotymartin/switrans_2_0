import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';

class ResolucionDocumentoModel extends ResolucionDocumento {
  ResolucionDocumentoModel({
    required super.codigo,
    required super.nombre,
  });

  factory ResolucionDocumentoModel.fromApi(Map<String, dynamic> map) => ResolucionDocumentoModel(
        codigo: map['codigoDocumento'],
        nombre: map['nombre'],
      );
}
