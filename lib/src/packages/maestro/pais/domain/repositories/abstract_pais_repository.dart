import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/pais.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/domain/entities/request/pais_request.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractPaisRepository {
  Future<DataState<List<Pais>>> getPaisesService(PaisRequest request);
  Future<DataState<Pais>> setPaisService(PaisRequest request);
  Future<DataState<Pais>> updatePaisService(PaisRequest request);
}
