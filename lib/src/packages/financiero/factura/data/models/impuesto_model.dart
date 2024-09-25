import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';

class ImpuestoModel extends Impuesto {
  ImpuestoModel({
    required super.nombre,
    required super.codigoTipoImpuesto,
    required super.codigoTransaccionContable,
    required super.valor,
    super.factorConversion,
    super.porcentaje,
  });

  factory ImpuestoModel.fromJson(Map<String, dynamic> json) => ImpuestoModel(
        nombre: json['nombre'],
        codigoTipoImpuesto: json['codigoTipoImpuesto'],
        codigoTransaccionContable: json['codigoTransaccionContable'],
        valor: json['valor'],
        factorConversion: json['factorConversion'] ?? 0,
        porcentaje: json['porcentaje'] ?? 0,
      );
}
