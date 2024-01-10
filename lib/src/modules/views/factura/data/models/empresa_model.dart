import 'package:switrans_2_0/src/modules/views/factura/domain/entities/empresa.dart';

class EmpresaModel extends Empresa {
  EmpresaModel({required super.codigo, required super.nombre, required super.nit});

  factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
        codigo: json["empresa_codigo"],
        nombre: json["empresa_nombre"],
        nit: json["empresa_documento"],
      );
}
