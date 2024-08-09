import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/unidad_negocio_empresa.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class AbstractUnidadNegocioRepository {
  Future<DataState<List<UnidadNegocio>>> getUnidadNegociosService(UnidadNegocioRequest request);
  Future<DataState<UnidadNegocio>> setUnidadNegocioService(UnidadNegocioRequest request);
  Future<DataState<UnidadNegocio>> updateUnidadNegocioService(UnidadNegocioRequest request);
  Future<DataState<List<UnidadNegocioEmpresa>>> getEmpresasService();
}
