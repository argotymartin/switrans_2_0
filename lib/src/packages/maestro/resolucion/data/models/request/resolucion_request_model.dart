import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';

class ResolucionRequestModel extends ResolucionRequest {
  ResolucionRequestModel({
    required super.codigo,
    required super.numero,
    required super.fecha,
    required super.rangoInicial,
    required super.rangoFinal,
    required super.fechaVigencia,
    required super.empresaPrefijo,
    required super.version,
    required super.isActiva,
    required super.codigoDocumento,
    required super.codigoEmpresa,
    super.codigoUsuario,
  });

  factory ResolucionRequestModel.fromRequest(ResolucionRequest request) => ResolucionRequestModel(
        codigo: request.codigo,
        numero: request.numero,
        fecha: request.fecha,
        rangoInicial: request.rangoInicial,
        rangoFinal: request.rangoFinal,
        fechaVigencia: request.fechaVigencia,
        empresaPrefijo: request.empresaPrefijo,
        version: request.version,
        isActiva: request.isActiva,
        codigoDocumento: request.codigoDocumento,
        codigoEmpresa: request.codigoEmpresa,
        codigoUsuario: request.codigoUsuario,
      );

  factory ResolucionRequestModel.fromTable(Map<String, dynamic> map) => ResolucionRequestModel(
        codigo: map['codigo'],
        numero: map['numero'],
        fecha: map['fecha'],
        rangoInicial: map['rango_inicial'] == String ? int.parse(map['rango_inicial']) : map['rango_inicial'],
        rangoFinal: map['rango_final'] == String ? int.parse(map['rango_final']) : map['rango_final'],
        fechaVigencia: map['vigencia'],
        empresaPrefijo: map['prefijo'],
        version: map['version'],
        isActiva: map['estado'],
        codigoDocumento: map['documento'],
        codigoEmpresa: map['empresa'],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numero': numero,
      'fecha': fecha,
      'rangoInicial': rangoInicial,
      'rangoFinal': rangoFinal,
      'fechaVigencia': fechaVigencia,
      'empresaPrefijo': empresaPrefijo,
      'version': version,
      'estado': isActiva,
      'codigoDocumento': codigoDocumento,
      'codigoEmpresa': codigoEmpresa,
      'codigoUsuario': codigoUsuario,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
