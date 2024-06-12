import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';

class TransaccionContableRequestModel extends TransaccionContableRequest {
  TransaccionContableRequestModel({
    required super.codigo,
    required super.nombre,
    required super.sigla,
    required super.isActivo,
    required super.secuencia,
    required super.tipoImpuesto,
  });

  factory TransaccionContableRequestModel.fromTable(Map<String, dynamic> map) => TransaccionContableRequestModel(
      codigo: map['tracon_codigo'],
      nombre: map['tracon_nombre'],
      sigla: map['tracon_sigla'],
      isActivo: map['tracon_es_activo'],
      secuencia: map['tracon_orden'],
      tipoImpuesto: map['tipimp_codigo'],
  );
}
