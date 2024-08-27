import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class AdicionModel extends Adicion {
  AdicionModel({required super.codigo, required super.nombre, required super.valor, required super.fecha});

  factory AdicionModel.fromJson(Map<String, dynamic> json) => AdicionModel(
        codigo: json['serempCodigo'],
        nombre: json['serempNombre'],
        valor: json['valor'],
        fecha: json['fecha'],
      );
}
