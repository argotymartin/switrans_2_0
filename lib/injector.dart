import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:switrans_2_0/src/globals/login/data/datasources/api/auth_pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/login/data/repositories/auth_repository_impl.dart';
import 'package:switrans_2_0/src/globals/login/domain/repositories/abstract_auth_repository.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/data/datasources/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/menu/data/repositories/menu_sidebar_repository_impl.dart';
import 'package:switrans_2_0/src/globals/menu/data/repositories/usuario_update_repository_impl.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_menu_sidebar_repository.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_usuario_update_repository.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/usuario/usuario_update_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/datasources/api/backend/factura_api.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/repositories/backend/factura_repository_impl.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/datasources/db/accion_documento_db.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/repositories/accion_documento_repository_db_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/datasources/api/modulo_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/data/repositories/modulo_repository_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/datasources/api/pagina_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/repositories/pagina_repository_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/pagina_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/datasources/api/paquete_api_pocketbase.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/data/repositories/paquete_repository_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/domain/repositories/abstract_paquete_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/data/datasources/db/resolucion_db.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/data/repositories/resolucion_respository_db_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/domain/resolucion_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/blocs/resolucion_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/data/datasources/db/servicio_empresarial_db.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/data/repositories/servicio_empresarial_repository_db_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/repositories/abstract_servicio_empresarial_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/datasources/api/tipo_impuesto_api.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/repositories/tipo_impuesto_repository_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/repositories/abstract_tipo_impuesto_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/datasources/db/transaccion_contable_db.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/data/repositories/transaccion_contable_repository_db_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/repositories/abstract_transaccion_contable_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/datasources/db/unidad_negocio_db.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/data/repositories/unidad_negocio_repository_db_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/repositories/abstract_unidad_negocio_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';

final GetIt injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<PocketbaseAPI>(PocketbaseAPI(injector()));
  injector.registerSingleton<AbstractMenuSidebarRepository>(MenuSidebarRespositoryImpl(injector()));
  injector.registerSingleton<MenuBloc>(MenuBloc(injector()));

  injector.registerSingleton<AbstractUsuarioUpdateRepository>(UsuarioUpdateRepositoryImpl(injector()));
  injector.registerSingleton<UsuarioUpdateBloc>(UsuarioUpdateBloc(injector()));

  injector.registerSingleton<ThemeCubit>(ThemeCubit());

  injector.registerSingleton<AuthPocketbaseApi>(AuthPocketbaseApi(injector()));
  injector.registerSingleton<AbstractAuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<AuthBloc>(AuthBloc(injector()));

  injector.registerSingleton<FacturaAPI>(FacturaAPI(injector()));
  injector.registerSingleton<AbstractFacturaRepository>(FacturaRepositoryImpl(injector()));
  //injector.registerSingleton<DocumentoBloc>(DocumentoBloc(injector()));
  injector.registerSingleton<FacturaBloc>(FacturaBloc(injector()));

  injector.registerSingleton<TipoImpuestoApi>(TipoImpuestoApi(injector()));
  injector.registerSingleton<AbstractTipoImpuestoRepository>(TipoImpuestoRepositoryImpl(injector()));
  injector.registerSingleton<TipoImpuestoBloc>(TipoImpuestoBloc(injector()));

  injector.registerSingleton<AccionDocumentoDB>(AccionDocumentoDB());
  injector.registerSingleton<AbstractAccionDocumentoRepository>(AccionDocumentoRepositoryDBImpl(injector()));
  injector.registerSingleton<AccionDocumentoBloc>(AccionDocumentoBloc(injector()));

  injector.registerSingleton<ServicioEmpresarialDB>(ServicioEmpresarialDB());
  injector.registerSingleton<AbstractServicioEmpresarialRepository>(ServicioEmpresarialDBImpl(injector()));
  injector.registerSingleton<ServicioEmpresarialBloc>(ServicioEmpresarialBloc(injector()));

  injector.registerSingleton<UnidadNegocioDB>(UnidadNegocioDB());
  injector.registerSingleton<AbstractUnidadNegocioRepository>(UnidadNegocioRepositoryDBImpl(injector()));
  injector.registerSingleton<UnidadNegocioBloc>(UnidadNegocioBloc(injector()));

  injector.registerSingleton<ModuloApiPocketBase>(ModuloApiPocketBase(injector()));
  injector.registerSingleton<AbstractModuloRepository>(ModuloRepositoryImpl(injector()));
  injector.registerSingleton<ModuloBloc>(ModuloBloc(injector()));

  injector.registerSingleton<PaqueteApiPocketBase>(PaqueteApiPocketBase(injector()));
  injector.registerSingleton<AbstractPaqueteRepository>(PaqueteRepositoryImpl(injector()));
  injector.registerSingleton<PaqueteBloc>(PaqueteBloc(injector()));

  injector.registerSingleton<TransaccionContableDB>(TransaccionContableDB());
  injector.registerSingleton<AbstractTransaccionContableRepository>(TransaccionContableRepositoryDBImpl(injector()));
  injector.registerSingleton<TransaccionContableBloc>(TransaccionContableBloc(injector()));

  injector.registerSingleton<PaginaApiPocketBase>(PaginaApiPocketBase(injector()));
  injector.registerSingleton<AbstractPaginaRepository>(PaginaRepositoryImpl(injector()));
  injector.registerSingleton<PaginaBloc>(PaginaBloc(injector()));

  injector.registerSingleton<ResolucionDB>(ResolucionDB(injector()));
  injector.registerSingleton<AbstractResolucionRepository>(ResolucionRespositoryDBImpl(injector()));
  injector.registerSingleton<ResolucionBloc>(ResolucionBloc(injector()));
}
