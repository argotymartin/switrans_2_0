import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractClienteRepository {
  Future<DataState<List<Cliente>>> getClientes();
  Future<DataState<List<Cliente>>> getCliente(String param);
}
