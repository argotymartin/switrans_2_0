import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/datasources/db/accion_documento_db.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/models/accion_documento_model.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/models/tipo_documento_accion_documento_model.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/repositories/abstract_accion_documento_repository.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class AccionDocumentoRepositoryDBImpl extends BaseApiRepository implements AbstractAccionDocumentoRepository {
  final AccionDocumentoDB _accionDocumentoDB;
  AccionDocumentoRepositoryDBImpl(this._accionDocumentoDB);

  @override
  Future<DataState<List<AccionDocumento>>> getAccionDocumentosService(AccionDocumentoRequest request) async {
    final httpResponse = await getStateOf(request: () => _accionDocumentoDB.getAccionDocumentosDB(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data;
      final response = List<AccionDocumento>.from(resp.map((x) => AccionDocumentoModel.fromJson(x)));
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<AccionDocumento>> setAccionDocumentosService(AccionDocumentoRequest request) async {
    final httpResponse = await getStateOf(request: () => _accionDocumentoDB.setAccionDocumentosDB(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data[0];
      final AccionDocumentoModel response = AccionDocumentoModel.fromJson(resp);
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<List<TipoDocumentoAccionDocumento>>> getTipoDocumentosService() async {
    final httpResponse = await getStateOf(request: () => _accionDocumentoDB.getTipoDocumentosDB());
    if (httpResponse.data != null) {
      final resp = httpResponse.data;
      final response = List<TipoDocumentoAccionDocumento>.from(resp.map((x) => TipoDocumentoAccionDocumentoModel.fromJson(x)));
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }

  @override
  Future<DataState<AccionDocumento>> updateAccionDocumentosService(AccionDocumentoRequest request) async {
    final httpResponse = await getStateOf(request: () => _accionDocumentoDB.updateAccionDocumentosDB(request));
    if (httpResponse.data != null) {
      final resp = httpResponse.data[0];
      final AccionDocumentoModel response = AccionDocumentoModel.fromJson(resp);
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
  }
}
