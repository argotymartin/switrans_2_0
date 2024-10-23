import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/domain/domain.dart';

class TransaccionContableRequestModel extends TransaccionContableRequest {
  TransaccionContableRequestModel({
    required super.codigo,
    required super.nombre,
    required super.isActivo,
    required super.sigla,
    required super.orden,
    required super.fechaCreacion,
    required super.codigoUsuario,
    required super.nombreUsuario,
    required super.tipoImpuesto,
  });

  factory TransaccionContableRequestModel.fromMap(Map<String, dynamic> map) => TransaccionContableRequestModel(
    codigo: map['codigo'],
    nombre: map['nombre'],
    isActivo: map['isActivo'],
    sigla: map['sigla'],
    fechaCreacion: map['fechaCreacion'],
    codigoUsuario: map['codigoUsuario'],
    nombreUsuario: map['nombreUsuario'],
    orden: map['secuencia'],
    tipoImpuesto: map['tipo_impuesto'],
  );


  factory TransaccionContableRequestModel.fromRequest(TransaccionContableRequest request) {
    return TransaccionContableRequestModel(
        codigo: request.codigo,
        nombre: request.nombre,
        isActivo: request.isActivo,
        sigla: request.sigla,
        orden: request.orden,
        fechaCreacion: request.fechaCreacion,
        codigoUsuario: request.codigoUsuario,
        nombreUsuario: request.nombreUsuario,
        tipoImpuesto: request.tipoImpuesto,
      );
  }


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombre': nombre,
      'sigla': sigla,
      'estado': isActivo,
      'orden': orden,
      'codigoUsuario': codigoUsuario,
      'nombreUsuario': nombreUsuario,
      'codigoTipoImpuesto': tipoImpuesto,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
