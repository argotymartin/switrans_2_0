import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/transaccion_contable_tipo_impuesto.dart';

class TransaccionContableTipoImpuestoModel extends TransaccionContableTipoImpuesto {
  TransaccionContableTipoImpuestoModel({
    required super.codigo,
    required super.nombre,
  });

  factory TransaccionContableTipoImpuestoModel.fromDB(Map<String, dynamic> map) => TransaccionContableTipoImpuestoModel(
        codigo: map['tipimp_codigo'],
        nombre: map['tipimp_nombre'],
      );

  factory TransaccionContableTipoImpuestoModel.fromJson(Map<String, dynamic> map) => TransaccionContableTipoImpuestoModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
      );
}
