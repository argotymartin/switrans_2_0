import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';

class EmpresaModel extends Empresa {
  EmpresaModel({
    required super.codigo,
    required super.nombre,
    required super.nit,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
        codigo: json["codigo"],
        nombre: json["empresa"],
        nit: json["nit"],
      );
}
