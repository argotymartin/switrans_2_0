import 'package:switrans_2_0/src/packages/financiero/factura/data/datasources/api/backend/factura_api.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/cliente_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/documento_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/empresa_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/tipo_documento_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/backend/backend_response.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class FacturaRepositoryImpl extends BaseApiRepository implements AbstractFacturaRepository {
  final FacturaAPI _api;

  FacturaRepositoryImpl(this._api);
  @override
  Future<DataState<List<Empresa>>> getEmpresasService() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getEmpresasApi());
    if (httpResponse.data != null) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      final List<Empresa> response =
          resp.data.cast<Map<String, dynamic>>().map((Map<String, dynamic> x) => EmpresaModel.fromJson(x)).toList();
      return DataSuccess<List<Empresa>>(response);
    }
    return DataFailed<List<Empresa>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<Cliente>>> getClientes() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getClienteApi());
    if (httpResponse.data != null) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      final List<Cliente> response =
          resp.data.cast<Map<String, dynamic>>().map((Map<String, dynamic> x) => ClienteModel.fromJson(x)).toList();

      return DataSuccess<List<Cliente>>(response);
    }
    return DataFailed<List<Cliente>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<Documento>>> getDocumentosService(FormFacturaRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getDocumentosApi(request));
    if (httpResponse.data != null) {
      final BackendResponse resp = BackendResponse.fromJson(httpResponse.data);
      final List<Documento> response =
          resp.data.cast<Map<String, dynamic>>().map((Map<String, dynamic> x) => DocumentoModel.fromJson(x)).toList();
      return DataSuccess<List<Documento>>(response);
    }
    return DataFailed<List<Documento>>(httpResponse.error!);
  }

  @override
  Future<DataState<List<TipoDocumento>>> getTipoDocumento() async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _api.getTipoDocumentoApi());
    if (httpResponse.data != null) {
      final List<TipoDocumento> response = List<TipoDocumento>.from(httpResponse.data.map((dynamic x) => TipoDocumentoModel.fromJson(x)));
      return DataSuccess<List<TipoDocumento>>(response);
    }
    return DataFailed<List<TipoDocumento>>(httpResponse.error!);
  }
}
