import 'dart:convert';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/data.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/backend/backend_response.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class DepartamentoRepositoryImpl extends BaseApiRepository implements AbstractDepartamentoRepository {
  final DepartamentoApi _api;
  DepartamentoRepositoryImpl(this._api);

  @override
  Future<DataState<List<Departamento>>> getDepartamentosService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getDepartamentosApi(request));
    if (httpResponse.data != null) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      final List<Departamento> response = List<Departamento>.from(resp.data.map((dynamic x) => DepartamentoModel.fromJson(x)));
      return DataSuccess<List<Departamento>>(response);
    }
    return DataFailed<List<Departamento>>(httpResponse.error!);
  }

  @override
  Future<DataState<Departamento>> setDepartamentoService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setDepartamentoApi(request));
    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final dynamic responseData = httpResponse.data['data'];
      final Departamento response = DepartamentoModel.fromJson(responseData);
      return DataSuccess<Departamento>(response);
    }
    return DataFailed<Departamento>(httpResponse.error!);
  }

  @override
  Future<DataState<Departamento>> updateDepartamentoService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateDepartamentoApi(request));

    if (httpResponse.data != null && httpResponse is DataSuccess) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      if (resp.success) {
        final dynamic responseData = resp.data;
        if (responseData is List && responseData.isNotEmpty) {
          final Map<String, dynamic> firstItem = responseData.first as Map<String, dynamic>;
          final Departamento response = DepartamentoModel.fromJson(firstItem);
          return DataSuccess<Departamento>(response);
        }
      }
    }
    return DataFailed<Departamento>(httpResponse.error!);
  }

  @override
  Future<DataState<List<DepartamentoPais>>> getPaisesService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaisesApi());
    if (httpResponse.data != null) {
      final dynamic responseData = jsonDecode(httpResponse.data);
      final BackendResponse resp = BackendResponse.fromJson(responseData);
      final List<DepartamentoPais> response = List<DepartamentoPais>.from(resp.data.map((dynamic x) => DepartamentoPaisModel.fromJson(x)));
      return DataSuccess<List<DepartamentoPais>>(response);
    }
    return DataFailed<List<DepartamentoPais>>(httpResponse.error!);
  }
}
