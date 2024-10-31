import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractAccionDocumentoRepository {
  Future<DataState<List<AccionDocumento>>> getAccionDocumentosService(AccionDocumentoRequest request);
  Future<DataState<AccionDocumento>> setAccionDocumentoService(AccionDocumentoRequest request);
  Future<DataState<AccionDocumento>> updateAccionDocumentosService(EntityUpdate<AccionDocumentoRequest> request);
  Future<DataState<List<AccionDocumentoDocumento>>> getDocumentosService();
}
