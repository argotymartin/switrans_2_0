import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractMunicipioRepository {
  Future<DataState<List<Municipio>>> getMunicipiosService(MunicipioRequest request);
  Future<DataState<Municipio>> setMunicipioService(MunicipioRequest request);
  Future<DataState<Municipio>> updateMunicipioService(EntityUpdate<MunicipioRequest> request);
  Future<DataState<List<MunicipioDepartamento>>> getDepartamentosService();
}
