import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractModuloRepository {
  Future<DataState<List<Paquete>>> getModulos();
}
