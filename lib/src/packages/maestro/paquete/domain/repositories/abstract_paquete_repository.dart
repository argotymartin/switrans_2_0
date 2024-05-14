import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractPaqueteRepository {
  Future<DataState<List<Paquete>>> getPaquetesService(PaqueteRequest request);
  Future<DataState<Paquete>> setPaqueteService(PaqueteRequest request);
  Future<DataState<Paquete>> updatePaqueteService(PaqueteRequest request);
}
