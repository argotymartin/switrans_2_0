import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class DescuentoModel extends Descuento {
  DescuentoModel({
    required super.codigo,
    required super.tipo,
    required super.valor,
  });

  factory DescuentoModel.fromJson(Map<String, dynamic> json) => DescuentoModel(
        codigo: json['codigo'],
        tipo: json['tipo'],
        valor: json['valor'],
      );
}
