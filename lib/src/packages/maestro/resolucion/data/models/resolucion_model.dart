import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/domain.dart';

class ResolucionModel extends Resolucion {
  ResolucionModel({
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
    required super.nombreDocumento,
    required super.codigoEmpresa,
    required super.nombreEmpresa,
    required super.codigoUsuario,
    required super.nombreUsuario,
  });

  factory ResolucionModel.fromApi(Map<String, dynamic> map) => ResolucionModel(
        codigo: map['codigo'],
        numero: map['numero'],
        fecha: map['fecha'],
        rangoInicial: map['rangoInicial'],
        rangoFinal: map['rangoFinal'],
        fechaVigencia: map['fechaVigencia'],
        empresaPrefijo: map['empresaPrefijo'],
        version: map['version'],
        isActiva: map['estado'],
        codigoDocumento: map['codigoDocumento'],
        nombreDocumento: map['nombreDocumento'],
        codigoEmpresa: map['codigoEmpresa'],
        nombreEmpresa: map['nombreEmpresa'],
        codigoUsuario: map['codigoUsuario'],
        nombreUsuario: map['nombreUsuario'],
      );
}
