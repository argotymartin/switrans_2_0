import 'package:flutter/foundation.dart';
import 'package:test/test.dart';
import 'pais_request_test.dart';
export 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';

const String successIcon = '✔';
const String failIcon = '✘';
const String successColor = '\x1B[32m';
const String failColor = '\x1B[31m';
const String resetColor = '\x1B[0m';

String repeatChar(String char, int count) {
  return char * count;
}

void main() {
  group('PaisRequest Tests', () {
    setUp(() {
      debugPrintSynchronously(repeatChar('=', 38));
      debugPrintSynchronously('===== Iniciando nueva prueba =====');
    });

    tearDown(() {
      debugPrintSynchronously('===== Prueba finalizada =====');
      debugPrintSynchronously(repeatChar('=', 38));
    });

    tearDownAll(() {
      debugPrintSynchronously(repeatChar('=', 38));
      debugPrintSynchronously('===== Todas las pruebas de PaisRequest han finalizado =====');
      debugPrintSynchronously(repeatChar('=', 38));
    });

    test('clean establece todos los campos en nulo y hasNonNullField funciona correctamente', () {
      final PaisRequest paisRequest = PaisRequest(codigo: 1, nombre: 'Colombia', isActivo: true);
      paisRequest.clean();

      expect(
        paisRequest.codigo,
        null,
        reason: '$failColor$failIcon Error - el campo "código" debería ser nulo después de limpiar.$resetColor',
      );
      debugPrintSynchronously(
        paisRequest.codigo == null
            ? '$successColor$successIcon Campo "código" se limpió correctamente.$resetColor'
            : '$failColor$failIcon Error - el campo "código" debería ser nulo después de limpiar.$resetColor',
      );

      expect(
        paisRequest.nombre,
        null,
        reason: '$failColor$failIcon Error - el campo "nombre" debería ser nulo después de limpiar.$resetColor',
      );
      debugPrintSynchronously(
        paisRequest.nombre == null
            ? '$successColor$successIcon Campo "nombre" se limpió correctamente.$resetColor'
            : '$failColor$failIcon Error - el campo "nombre" debería ser nulo después de limpiar.$resetColor',
      );

      expect(
        paisRequest.isActivo,
        null,
        reason: '$failColor$failIcon Error - el campo "estado" debería ser nulo después de limpiar.$resetColor',
      );
      debugPrintSynchronously(
        paisRequest.isActivo == null
            ? '$successColor$successIcon Campo "estado" se limpió correctamente.$resetColor'
            : '$failColor$failIcon Error - el campo "estado" debería ser nulo después de limpiar.$resetColor',
      );

      expect(
        paisRequest.hasNonNullField(),
        false,
        reason: '$failColor$failIcon Error - se esperaba que todos los campos fueran nulos.$resetColor',
      );
      debugPrintSynchronously(
        !paisRequest.hasNonNullField()
            ? '$successColor$successIcon hasNonNullField() retornó false, como se esperaba.$resetColor'
            : '$failColor$failIcon Error - se esperaba que hasNonNullField retornara false, pero no lo hizo.$resetColor',
      );

      final PaisRequest paisRequest2 = PaisRequest(nombre: 'Colombia', isActivo: true);
      expect(
        paisRequest2.hasNonNullField(),
        true,
        reason: '$failColor$failIcon Error - se esperaba que al menos un campo no fuera nulo.$resetColor',
      );
      debugPrintSynchronously(
        paisRequest2.hasNonNullField()
            ? '$successColor$successIcon hasNonNullField() retornó verdadero, indicando que al menos un campo no es nulo.$resetColor'
            : '$failColor$failIcon Error - se esperaba que hasNonNullField retornara verdadero, pero no lo hizo.$resetColor',
      );
    });
  });
}
