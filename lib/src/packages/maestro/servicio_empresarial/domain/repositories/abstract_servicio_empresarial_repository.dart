import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/servicio_empresarial.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/resources/entity_update.dart';

abstract class AbstractServicioEmpresarialRepository {
  Future<DataState<List<ServicioEmpresarial>>> getServicioEmpresarialService(ServicioEmpresarialRequest request);
  Future<DataState<ServicioEmpresarial>> setServicioEmpresarialService(ServicioEmpresarialRequest request);
  Future<DataState<ServicioEmpresarial>> updateServicioEmpresarialService(EntityUpdate<ServicioEmpresarialRequest> request);
}
