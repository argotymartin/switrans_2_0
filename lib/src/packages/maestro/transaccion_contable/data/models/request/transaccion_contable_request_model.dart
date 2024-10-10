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

  factory TransaccionContableRequestModel.fromRequest(TransaccionContableRequest request) => TransaccionContableRequestModel(
        codigo: request.codigo,
        nombre: request.nombre,
        sigla: request.sigla,
        isActivo: request.isActivo,
        secuencia: request.secuencia,
        tipoImpuesto: request.tipoImpuesto,
      );

  factory TransaccionContableRequestModel.fromMapTable(Map<String, dynamic> map) => TransaccionContableRequestModel(
        codigo: map['codigo'],
        nombre: map['nombre'],
        sigla: map['sigla'],
        isActivo: map['activo'],
        secuencia: map['secuencia'],
        tipoImpuesto: map['tipo_impuesto'],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'sigla': sigla,
      'isActivo': isActivo,
      'secuencia': secuencia,
      'tipoImpuesto': tipoImpuesto,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
