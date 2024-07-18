import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class AdicionModel extends Adicion {
  AdicionModel({
    required super.codigo,
    required super.tipo,
    required super.valor,
  });

  factory AdicionModel.fromJson(Map<String, dynamic> json) => AdicionModel(
        codigo: json['codigo'],
        tipo: json['tipo'],
        valor: json['valor'],
      );
}
