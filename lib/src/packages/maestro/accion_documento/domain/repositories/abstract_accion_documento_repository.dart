import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/accion_documento.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

abstract class AbstractAccionDocumentoRepository {
  Future<DataState<List<AccionDocumento>>> getAccionDocumentosService(AccionDocumentoRequest request);
  Future<DataState<List<TipoDocumentoAccionDocumento>>> getTipoDocumentosService();
  Future<DataState<AccionDocumento>> setAccionDocumentosService(AccionDocumentoRequest request);
  Future<DataState<AccionDocumento>> updateAccionDocumentosService(EntityUpdate<AccionDocumentoRequest> request);
}
