class Impuesto {
  final String nombre;
  final int codigoTipoImpuesto;
  final int codigoTransaccionContable;
  final double valor;
  final double? porcentaje;
  final int? factorConversion;

  Impuesto({
    required this.nombre,
    required this.codigoTipoImpuesto,
    required this.codigoTransaccionContable,
    required this.valor,
    this.porcentaje,
    this.factorConversion,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "codigoTipoImpuesto": codigoTipoImpuesto,
        "codigoTransaccionContable": codigoTransaccionContable,
        "nombre": nombre,
        "valor": valor,
      };
}
