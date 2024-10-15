import 'package:switrans_2_0/src/packages/maestro/departamento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class DepartamentoRepositoryImpl extends BaseApiRepository implements AbstractDepartamentoRepository {
  final DepartamentoApi _api;
  DepartamentoRepositoryImpl(this._api);

  @override
  Future<DataState<List<Departamento>>> getDepartamentosService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getDepartamentosApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<Departamento> departamentos =
          List<Departamento>.from(backendResponse.data.map((dynamic x) => DepartamentoModel.fromJson(x)));
      return DataSuccess<List<Departamento>>(departamentos);
    }
    return DataFailed<List<Departamento>>(httpResponse.error!);
  }

  @override
  Future<DataState<Departamento>> setDepartamentoService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setDepartamentoApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final Departamento departamento = DepartamentoModel.fromJson(backendResponse.data);
      return DataSuccess<Departamento>(departamento);
    }
    return DataFailed<Departamento>(httpResponse.error!);
  }

  @override
  Future<DataState<Departamento>> updateDepartamentoService(EntityUpdate<DepartamentoRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateDepartamentoApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      if (backendResponse.success) {
        final dynamic responseData = backendResponse.data;
        if (responseData is List && responseData.isNotEmpty) {
          final Map<String, dynamic> firstItem = responseData.first as Map<String, dynamic>;
          final Departamento departamento = DepartamentoModel.fromJson(firstItem);
          return DataSuccess<Departamento>(departamento);
        }
      }
    }
    return DataFailed<Departamento>(httpResponse.error!);
  }

  @override
  Future<DataState<List<DepartamentoPais>>> getPaisesService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaisesApi());
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse backendResponse = BackendResponse.fromJson(httpResponse.data);
      final List<DepartamentoPais> departamentoPaises =
          List<DepartamentoPais>.from(backendResponse.data.map((dynamic x) => DepartamentoPaisModel.fromJson(x)));
      return DataSuccess<List<DepartamentoPais>>(departamentoPaises);
    }
    return DataFailed<List<DepartamentoPais>>(httpResponse.error!);
  }
}
