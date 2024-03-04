import 'package:switrans_2_0/src/modules/financiero/factura/domain/entities/cliente.dart';

class ClienteModel extends Cliente {
  ClienteModel({
    required super.codigo,
    required super.nombre,
    required super.identificacion,
    required super.telefono,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        identificacion: json["identificacion"],
        telefono: json["telefono"],
      );
}
