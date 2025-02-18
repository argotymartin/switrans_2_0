import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/datasources/db/accion_documento_db.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/models/accion_documento_model.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/models/tipo_documento_accion_documento_model.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/repositories/abstract_accion_documento_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class AccionDocumentoRepositoryDBImpl extends BaseApiRepository implements AbstractAccionDocumentoRepository {
  final AccionDocumentoDB _accionDocumentoDB;
  AccionDocumentoRepositoryDBImpl(this._accionDocumentoDB);

  @override
  Future<DataState<List<AccionDocumento>>> getAccionDocumentosService(AccionDocumentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _accionDocumentoDB.getAccionDocumentosDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;
      final List<AccionDocumento> response = List<AccionDocumento>.from(resp.map((dynamic x) => AccionDocumentoModel.fromJson(x)));
      return DataSuccess<List<AccionDocumento>>(response);
    }
    return DataFailed<List<AccionDocumento>>(httpResponse.error!);
  }

  @override
  Future<DataState<AccionDocumento>> setAccionDocumentosService(AccionDocumentoRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _accionDocumentoDB.setAccionDocumentosDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data[0];
      final AccionDocumento response = AccionDocumentoModel.fromJson(resp);
      return DataSuccess<AccionDocumento>(response);
    }
    return DataFailed<AccionDocumento>(httpResponse.error!);
  }

  @override
  Future<DataState<List<TipoDocumentoAccionDocumento>>> getTipoDocumentosService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _accionDocumentoDB.getTipoDocumentosDB());
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;
      final List<TipoDocumentoAccionDocumento> response =
          List<TipoDocumentoAccionDocumento>.from(resp.map((dynamic x) => TipoDocumentoAccionDocumentoModel.fromJson(x)));
      return DataSuccess<List<TipoDocumentoAccionDocumento>>(response);
    }
    return DataFailed<List<TipoDocumentoAccionDocumento>>(httpResponse.error!);
  }

  @override
  Future<DataState<AccionDocumento>> updateAccionDocumentosService(EntityUpdate<AccionDocumentoRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _accionDocumentoDB.updateAccionDocumentosDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data[0];
      final AccionDocumento response = AccionDocumentoModel.fromJson(resp);
      return DataSuccess<AccionDocumento>(response);
    }
    return DataFailed<AccionDocumento>(httpResponse.error!);
  }
}
