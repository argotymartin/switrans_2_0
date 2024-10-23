import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/domain/domain.dart';

class TransaccionContableModel extends TransaccionContable {
  TransaccionContableModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.sigla,
    required super.orden,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.tipoimpuesto,
  });

  factory TransaccionContableModel.fromJson(Map<String, dynamic> json) => TransaccionContableModel(
        codigo: json['codigo'],
        nombre: json['nombre'],
        isActivo: json['estado'],
        sigla: json['sigla'],
        orden: json['orden'],
        fechaCreacion: json['fechaCreacion'].toString(),
        codigoUsuario: json['codigoUsuario'],
        nombreUsuario: json['nombreUsuario'],
        tipoimpuesto: json['codigoTipoImpuesto'],
      );
}
