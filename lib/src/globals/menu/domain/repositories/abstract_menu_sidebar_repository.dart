import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractMenuSidebarRepository {
  Future<DataState<List<PaqueteMenu>>> getModulos();
}
