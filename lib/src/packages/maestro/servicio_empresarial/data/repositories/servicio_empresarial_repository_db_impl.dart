import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/data/datasources/db/servicio_empresarial_db.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/data/models/servicio_empresarial_model.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/servicio_empresarial.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/repositories/abstract_servicio_empresarial_repository.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class ServicioEmpresarialDBImpl extends BaseApiRepository implements AbstractServicioEmpresarialRepository {
  final ServicioEmpresarialDB _servicioEmpresarialDB;

  ServicioEmpresarialDBImpl(this._servicioEmpresarialDB);

  @override
  Future<DataState<List<ServicioEmpresarial>>> getServicioEmpresarialService(ServicioEmpresarialRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _servicioEmpresarialDB.getServicioEmpresarialDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data;
      final List<ServicioEmpresarial> response =
          List<ServicioEmpresarial>.from(resp.map((dynamic x) => ServicioEmpresarialModel.fromDB(x)));
      return DataSuccess<List<ServicioEmpresarial>>(response);
    }
    return DataFailed<List<ServicioEmpresarial>>(httpResponse.error!);
  }

  @override
  Future<DataState<ServicioEmpresarial>> setServicioEmpresarialService(ServicioEmpresarialRequest request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _servicioEmpresarialDB.setServicioEmpresarialDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data[0];
      final ServicioEmpresarial response = ServicioEmpresarialModel.fromDB(resp);
      return DataSuccess<ServicioEmpresarial>(response);
    }
    return DataFailed<ServicioEmpresarial>(httpResponse.error!);
  }

  @override
  Future<DataState<ServicioEmpresarial>> updateServicioEmpresarialService(EntityUpdate<ServicioEmpresarialRequest> request) async {
    final DataState<dynamic> httpResponse = await getStateOf(request: () => _servicioEmpresarialDB.updateServicioEmpresarialDB(request));
    if (httpResponse.data != null) {
      final dynamic resp = httpResponse.data[0];
      final ServicioEmpresarial response = ServicioEmpresarialModel.fromDB(resp);
      return DataSuccess<ServicioEmpresarial>(response);
    }
    return DataFailed<ServicioEmpresarial>(httpResponse.error!);
  }
}
