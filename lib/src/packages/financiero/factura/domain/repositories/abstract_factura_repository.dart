import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractFacturaRepository {
  Future<DataState<List<Cliente>>> getClientes();
  Future<DataState<List<Cliente>>> getCliente(String param);
  Future<DataState<List<Empresa>>> getEmpresasService();
  Future<DataState<List<Documento>>> getDocumentosService(FacturaRequest request);
}
