import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractDepartamentoRepository {
  Future<DataState<List<Departamento>>> getDepartamentosService(DepartamentoRequest request);
  Future<DataState<Departamento>> setDepartamentoService(DepartamentoRequest request);
  Future<DataState<Departamento>> updateDepartamentoService(EntityUpdate<DepartamentoRequest> request);
  Future<DataState<List<DepartamentoPais>>> getPaisesService();
}
