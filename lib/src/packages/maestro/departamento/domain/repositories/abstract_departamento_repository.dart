import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento_pais.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/request/departamento_request.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractDepartamentoRepository {
  Future<DataState<List<Departamento>>> getDepartamentosService(DepartamentoRequest request);
  Future<DataState<Departamento>> setDepartamentoService(DepartamentoRequest request);
  Future<DataState<Departamento>> updateDepartamentoService(DepartamentoRequest request);
  Future<DataState<List<DepartamentoPais>>> getPaisesService();
}
