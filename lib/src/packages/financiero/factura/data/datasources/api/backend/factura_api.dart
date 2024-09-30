import 'package:dio/dio.dart';

import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/request/form_factura_request_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

const String endPoint = "api/v1/erp/facturas";

class FacturaAPI {
  final Dio _dio;
  FacturaAPI(this._dio);

  Future<Response<dynamic>> getTipoDocumentoApi() async {
    final String url = '$kBackendBaseUrlERP/$endPoint/documentos/tipos';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getEmpresasApi() async {
    final String url = '$kBackendBaseUrlERP/$endPoint/empresas';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getClienteApi() async {
    final String url = '$kBackendBaseUrlERP/$endPoint/clientes';
    final Response<dynamic> response = await _dio.get(url);
    return response;
  }

  Future<Response<dynamic>> getDocumentosApi(FormFacturaRequest request) async {
    final FormFacturaRequestModel requestModel = FormFacturaRequestModel.fromRequest(request);
    final String url = '$kBackendBaseUrlERP/$endPoint/documentos';

    final Map<String, dynamic> params = requestModel.toJson();
    final Response<dynamic> response = await _dio.get(url, queryParameters: params);
    return response;
  }
}
