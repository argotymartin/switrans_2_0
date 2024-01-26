import 'package:switrans_2_0/src/globals/menu/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractModuloRepository {
  Future<DataState<List<Modulo>>> getModulos();
}
