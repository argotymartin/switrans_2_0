import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractPaginaRepository {
  Future<DataState<List<Pagina>>> getPaginasService(PaginaRequest request);
  Future<DataState<Pagina>> setPaginaService(PaginaRequest request);
  Future<DataState<Pagina>> updatePaginaService(PaginaRequest request);
}
