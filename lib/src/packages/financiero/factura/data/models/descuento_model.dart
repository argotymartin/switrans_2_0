import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class DescuentoModel extends Descuento {
  DescuentoModel({required super.codigo, required super.nombre, required super.valor, required super.fecha});

  factory DescuentoModel.fromJson(Map<String, dynamic> json) => DescuentoModel(
        codigo: json['serempCodigo'],
        nombre: json['serempNombre'],
        valor: json['valor'],
        fecha: json['fecha'],
      );
}
