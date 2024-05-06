import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/modulo_paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/entities/request/modulo_request.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractModuloRepository {
  Future<DataState<List<Modulo>>> getModulosService(ModuloRequest request);
  Future<DataState<Modulo>> setModuloService(ModuloRequest request);
  Future<DataState<Modulo>> updateModuloService(ModuloRequest request);
  Future<DataState<List<ModuloPaquete>>> getPaquetesService();
}
