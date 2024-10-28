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
    required super.codigoTipoImpuesto,
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
    codigoTipoImpuesto: map['codigoTipoImpuesto'],
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
        codigoTipoImpuesto: request.codigoTipoImpuesto,
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
      'codigoTipoImpuesto': codigoTipoImpuesto,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
