import 'dart:convert';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/datasources/api/pocketbase//departamento_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/models/departamento_model.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/data/models/departamento_pais_model.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/departamento_pais.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/entities/request/departamento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/domain/repositories/abstract_departamento_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class DepartamentoRepositoryImpl extends BaseApiRepository implements AbstractDepartamentoRepository {
  final DepartamentoApiPocketBase _api;
  DepartamentoRepositoryImpl(this._api);

  @override
  Future<DataState<List<Departamento>>> getDepartamentosService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getDepartamentosApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = jsonDecode(httpResponse.data);
      final List<dynamic> items = responseData['items'];
      final List<Departamento> response = items.map((dynamic item) => DepartamentoModel.fromJson(item)).toList();
      return DataSuccess<List<Departamento>>(response);
    }
    return DataFailed<List<Departamento>>(httpResponse.error!);
  }

  @override
  Future<DataState<Departamento>> setDepartamentoService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setDepartamentoApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = json.decode(httpResponse.data);
      final Departamento response = DepartamentoModel.fromJson(responseData);
      return DataSuccess<Departamento>(response);
    }
    return DataFailed<Departamento>(httpResponse.error!);
  }

  @override
  Future<DataState<List<DepartamentoPais>>> getPaisesService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaisesApi());
    if (httpResponse.data != null) {
      final dynamic responseData = json.decode(httpResponse.data);
      final dynamic resp = responseData['items'];
      final List<DepartamentoPais> response = List<DepartamentoPais>.from(resp.map((dynamic x) => DepartamentoPaisModel.fromJson(x)));
      return DataSuccess<List<DepartamentoPais>>(response);
    }
    return DataFailed<List<DepartamentoPais>>(httpResponse.error!);
  }

  @override
  Future<DataState<Departamento>> updateDepartamentoService(DepartamentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updateDepartamentoApi(request));
    if (httpResponse.data != null) {
      final Departamento response = DepartamentoModel.fromJson(httpResponse.data);
      return DataSuccess<Departamento>(response);
    }
    return DataFailed<Departamento>(httpResponse.error!);
  }
}
