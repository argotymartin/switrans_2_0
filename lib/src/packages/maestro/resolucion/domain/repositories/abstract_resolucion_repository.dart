import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractResolucionRepository {
  Future<DataState<List<Resolucion>>> getResolucionesService(ResolucionRequest request);
  Future<DataState<Resolucion>> setResolucionService(ResolucionRequest request);
  Future<DataState<Resolucion>> updateResolucionService(ResolucionRequest request);
  Future<DataState<List<ResolucionDocumento>>> getDocumentosService();
  Future<DataState<List<ResolucionEmpresa>>> getEmpresasService();
  Future<DataState<List<ResolucionCentroCosto>>> getCentroCostoService(ResolucionEmpresa request);
}
