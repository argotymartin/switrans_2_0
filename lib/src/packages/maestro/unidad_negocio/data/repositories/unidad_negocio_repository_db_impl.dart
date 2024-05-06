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
  Future<DataState<UnidadNegocio>> createUnidadNegocioService(UnidadNegocioRequest request) async {
    final httpResponse = await getStateOf(request: () => _unidadNegocioDB.setUnidadNegocioDB(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data[0];
      final UnidadNegocio response = UnidadNegocioModel.fromDB(resp);
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<List<UnidadNegocio>>> getUnidadNegocioService(UnidadNegocioRequest request) async {
    final httpResponse = await getStateOf(request: () => _unidadNegocioDB.getUnidadNegocioDB(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data;
      final response = List<UnidadNegocio>.from(resp.map((x) => UnidadNegocioModel.fromDB(x)));
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<UnidadNegocio>> updateUnidadNegocioService(UnidadNegocioRequest request) async {
    final httpResponse = await getStateOf(request: () => _unidadNegocioDB.updateUnidadNegocioDB(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data[0];
      final UnidadNegocio response = UnidadNegocioModel.fromDB(resp);
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<List<UnidadNegocioEmpresa>>> getEmpresasService() async {
    final httpResponse = await getStateOf(request: () => _unidadNegocioDB.getEmpresasDB());
    if (httpResponse.data != null) {
      final resp = httpResponse.data;
      final response = List<UnidadNegocioEmpresa>.from(resp.map((x) => UnidadNegocioEmpresaModel.fromDB(x)));
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }
}
