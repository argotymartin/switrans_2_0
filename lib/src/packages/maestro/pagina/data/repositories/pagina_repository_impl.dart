import 'dart:convert';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/datasources/api/pagina_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/pagina_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/repositories/abstract_pagina_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class PaginaRepositoryImpl extends BaseApiRepository implements AbstractPaginaRepository {
  final PaginaApiPocketBase _api;
  PaginaRepositoryImpl(this._api);

  @override
  Future<DataState<List<Pagina>>> getPaginasService(PaginaRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getPaginasApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = jsonDecode(httpResponse.data);
      final List<dynamic> items = responseData['items'];
      final List<Pagina> response = items.map((dynamic item) => PaginaModel.fromJson(item)).toList();
      return DataSuccess<List<Pagina>>(response);
    }
    return DataFailed<List<Pagina>>(httpResponse.error!);
  }

  @override
  Future<DataState<Pagina>> setPaginaService(PaginaRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.setPaginaApi(request));
    if (httpResponse.data != null) {
      final dynamic responseData = json.decode(httpResponse.data);
      final Pagina response = PaginaModel.fromJson(responseData);
      return DataSuccess<Pagina>(response);
    }
    return DataFailed<Pagina>(httpResponse.error!);
  }

  @override
  Future<DataState<Pagina>> updatePaginaService(PaginaRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.updatePaginaApi(request));
    if (httpResponse.data != null) {
      final Pagina response = PaginaModel.fromJson(httpResponse.data);
      return DataSuccess<Pagina>(response);
    }
    return DataFailed<Pagina>(httpResponse.error!);
  }
}
