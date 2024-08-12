import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/datasources/db/unidad_negocio_db.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/models/unidad_negocio_empresa_model.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/models/unidad_negocio_model.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/repositories/abstract_unidad_negocio_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class UnidadNegocioRepositoryDBImpl extends BaseApiRepository implements AbstractUnidadNegocioRepository {
  final UnidadNegocioDB _unidadNegocioDB;

  UnidadNegocioRepositoryDBImpl(this._unidadNegocioDB);

  @override
  Future<DataState<List<UnidadNegocio>>> getUnidadNegociosService(UnidadNegocioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _unidadNegocioDB.getUnidadNegocioDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;

      final List<UnidadNegocio> response = List<UnidadNegocio>.from(
        resp.map((Map<String, dynamic> x) => UnidadNegocioModel.fromDB(x)),
      );

      return DataSuccess<List<UnidadNegocio>>(response);
    }
    return DataFailed<List<UnidadNegocio>>(httpResponse.error!);
  }

  @override
  Future<DataState<UnidadNegocio>> setUnidadNegocioService(UnidadNegocioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _unidadNegocioDB.setUnidadNegocioDB(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = httpResponse.data[0];
      final UnidadNegocio response = UnidadNegocioModel.fromDB(dataJson);
      return DataSuccess<UnidadNegocio>(response);
    }
    return DataFailed<UnidadNegocio>(httpResponse.error!);
  }

  @override
  Future<DataState<UnidadNegocio>> updateUnidadNegocioService(UnidadNegocioRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _unidadNegocioDB.updateUnidadNegocioDB(request));
    if (httpResponse.data != null) {
      final dynamic dataJson = (httpResponse.data as List<dynamic>).first;
      final UnidadNegocio response = UnidadNegocioModel.fromDB(dataJson);
      return DataSuccess<UnidadNegocio>(response);
    }
    return DataFailed<UnidadNegocio>(httpResponse.error!);
  }

  @override
  Future<DataState<List<UnidadNegocioEmpresa>>> getEmpresasService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _unidadNegocioDB.getEmpresasDB());

    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;
      final List<UnidadNegocioEmpresa> response =
          List<UnidadNegocioEmpresa>.from(resp.map((dynamic x) => UnidadNegocioEmpresaModel.fromDB(x)));
      return DataSuccess<List<UnidadNegocioEmpresa>>(response);
    }
    return DataFailed<List<UnidadNegocioEmpresa>>(httpResponse.error!);
  }
}
