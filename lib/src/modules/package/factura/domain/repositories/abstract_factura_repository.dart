import 'package:switrans_2_0/src/modules/package/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/empresa.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractFacturaRepository {
  Future<DataState<List<Cliente>>> getClientes();
  Future<DataState<List<Cliente>>> getCliente(String param);
  Future<DataState<List<Empresa>>> getEmpresasService();
}
