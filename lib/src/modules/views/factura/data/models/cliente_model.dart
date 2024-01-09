import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';

class ClienteModel extends Cliente {
  ClienteModel({required super.codigo, required super.nombre, required super.identificacion});

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        codigo: json["cliente_codigo"],
        nombre: json["cliente_nombre"],
        identificacion: json["cliente_identificacion"],
      );
}
