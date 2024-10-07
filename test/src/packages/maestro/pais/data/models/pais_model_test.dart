import 'package:flutter/cupertino.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/data/models/pais_model.dart';
import 'package:test/test.dart';

const String successIcon = '✔';
const String failIcon = '✘';
const String successColor = '\x1B[32m';
const String failColor = '\x1B[31m';
const String resetColor = '\x1B[0m';

void logOperationStatus(bool success, String message) {
  final String logMessage = success ? '$successColor$successIcon $message$resetColor' : '$failColor$failIcon Error: $message$resetColor';
  debugPrint(logMessage);
}

void main() {
  group('PaisModel', () {
    test('fromJson creates an instance from JSON', () {
      final Map<String, Object> jsonMap = <String, Object>{
        'codigo': 1,
        'nombre': 'COLOMBIA',
        'estado': true,
        'fechaCreacion': '2006-10-14',
        'codigoUsuario': 1,
        'usuarioNombre': 'ADMINISTRADOR',
      };

      final PaisModel paisModel = PaisModel.fromJson(jsonMap);

      expect(paisModel.codigo, 1, reason: '$failColor$failIcon Error - el campo "codigo" no coincide con el valor esperado.$resetColor');
      logOperationStatus(paisModel.codigo == 1, 'Campo "codigo" coincide con el valor esperado.');

      expect(
        paisModel.nombre,
        'COLOMBIA',
        reason: '$failColor$failIcon Error - el campo "nombre" no coincide con el valor esperado.$resetColor',
      );
      logOperationStatus(paisModel.nombre == 'COLOMBIA', 'Campo "nombre" coincide con el valor esperado.');

      expect(
        paisModel.fechaCreacion,
        '2006-10-14',
        reason: '$failColor$failIcon Error - el campo "fechaCreacion" no coincide con el valor esperado.$resetColor',
      );
      logOperationStatus(paisModel.fechaCreacion == '2006-10-14', 'Campo "fechaCreacion" coincide con el valor esperado.');

      expect(
        paisModel.codigoUsuario,
        1,
        reason: '$failColor$failIcon Error - el campo "codigoUsuario" no coincide con el valor esperado.$resetColor',
      );
      logOperationStatus(paisModel.codigoUsuario == 1, 'Campo "codigoUsuario" coincide con el valor esperado.');

      expect(
        paisModel.usuarioNombre,
        'ADMINISTRADOR',
        reason: '$failColor$failIcon Error - el campo "usuarioNombre" no coincide con el valor esperado.$resetColor',
      );
      logOperationStatus(paisModel.usuarioNombre == 'ADMINISTRADOR', 'Campo "usuarioNombre" coincide con el valor esperado.');
    });

    test('fromJson throws an error on invalid JSON', () {
      final Map<String, Object> invalidJsonMap = <String, Object>{
        'codigo': 1,
        'nombre': 'COLOMBIA',
        'fechaCreacion': '2006-10-14',
        'codigoUsuario': 1,
        'usuarioNombre': 'ADMINISTRADOR',
      };

      expect(() => PaisModel.fromJson(invalidJsonMap), throwsA(isA<TypeError>()));
    });
  });
}
