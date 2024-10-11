import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/entities/request/paquete_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractPaqueteRepository {
  Future<DataState<List<Paquete>>> getPaquetesService(PaqueteRequest request);
  Future<DataState<Paquete>> setPaqueteService(PaqueteRequest request);
  Future<DataState<Paquete>> updatePaqueteService(EntityUpdate<PaqueteRequest> request);
}
