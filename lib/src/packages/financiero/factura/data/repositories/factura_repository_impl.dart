import 'package:switrans_2_0/src/packages/financiero/factura/data/datasorces/api/factura_api.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/cliente_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/documento_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/empresa_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/backend/backend_response.dart';
import 'package:switrans_2_0/src/util/resources/base_api.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

class FacturaRepositoryImpl extends BaseApiRepository implements AbstractFacturaRepository {
  final FacturaAPI _api;

  FacturaRepositoryImpl(this._api);
  @override
  Future<DataState<List<Empresa>>> getEmpresasService() async {
    final httpResponse = await getStateOf(request: () => _api.getEmpresasApi());
    if (httpResponse.data != null) {
      final resp = BackendResponse.fromJson(httpResponse.data);
      final List<Empresa> response = resp.data.cast<Map<String, dynamic>>().map((x) => EmpresaModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
    //return DataSuccess(FacturaDataTest.empresasResponse);
  }

  @override
  Future<DataState<List<Cliente>>> getClientes() async {
    final httpResponse = await getStateOf(request: () => _api.getClienteApi());
    if (httpResponse.data != null) {
      final resp = BackendResponse.fromJson(httpResponse.data);
      final List<Cliente> response = resp.data.cast<Map<String, dynamic>>().map((x) => ClienteModel.fromJson(x)).toList();

      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
    //return DataSuccess(FacturaDataTest.clinetesResponse);
  }

  @override
  Future<DataState<List<Cliente>>> getCliente(String param) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<Documento>>> getDocumentosService(FacturaRequest request) async {
    final httpResponse = await getStateOf(request: () => _api.getDocumentosApi(request));
    if (httpResponse.data != null) {
      final resp = BackendResponse.fromJson(httpResponse.data);
      final List<Documento> response = resp.data.cast<Map<String, dynamic>>().map((x) => DocumentoModel.fromJson(x)).toList();
      return DataSuccess(response);
    }
    return DataFailed(httpResponse.error!);
    //return DataSuccess(FacturaDataTest.remesasResponse);
  }
}
