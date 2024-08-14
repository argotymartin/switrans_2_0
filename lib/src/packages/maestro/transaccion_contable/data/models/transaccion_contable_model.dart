import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/transaccion_contable_domain.dart';

class TransaccionContableModel extends TransaccionContable {
  TransaccionContableModel({
    required super.codigo,
    required super.nombre,
    required super.sigla,
    required super.isActivo,
    required super.tipoimpuesto,
    required super.usuario,
    required super.secuencia,
    required super.fechaCreacion,
  });

  factory TransaccionContableModel.fromDB(Map<String, dynamic> map) => TransaccionContableModel(
        codigo: map['tracon_codigo'],
        nombre: map['tracon_nombre'],
        sigla: map['tracon_sigla'],
        isActivo: map['tracon_es_activo'],
        tipoimpuesto: map['impuesto'],
        usuario: map['usuario'],
        secuencia: map['tracon_orden'],
        fechaCreacion: map['tracon_fecha_creacion'].toString(),
      );
}
