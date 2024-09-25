class Impuesto {
  final int codigo;
  final String nombre;
  final double valor;
  final double? porcentaje;
  final int? factorConversion;

  Impuesto({
    required this.codigo,
    required this.nombre,
    required this.valor,
    this.porcentaje,
    this.factorConversion,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "codigo": codigo,
        "nombre": nombre,
        "valor": valor,
      };
}
