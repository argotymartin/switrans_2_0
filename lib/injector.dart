import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:switrans_2_0/src/globals/login/data/datasources/api/auth_pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/login/data/repositories/auth_repository_impl.dart';
import 'package:switrans_2_0/src/globals/login/domain/repositories/abstract_auth_repository.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/data/datasorces/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/menu/data/repositories/paquete_menu_repository_impl.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_paquete_menu_repository.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/datasorces/api/factura_api.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/repositories/factura_repository_impl.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/datasorces/db/accion_documento_db.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/data/repositories/accion_documento_repository_db_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/datasorces/api/tipo_impuesto_api.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/data/repositories/tipo_impuesto_repository_impl.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/domain/repositories/abstract_tipo_impuesto_repository.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<MenuBloc>(MenuBloc());
  injector.registerSingleton<ThemeCubit>(ThemeCubit());

  injector.registerSingleton<AuthPocketbaseApi>(AuthPocketbaseApi(injector()));
  injector.registerSingleton<AbstractAuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<AuthBloc>(AuthBloc(injector()));

  injector.registerSingleton<PocketbaseAPI>(PocketbaseAPI(injector()));
  injector.registerSingleton<AbstractPaqueteMenuRepository>(PaqueteMenuRespositoryImpl(injector()));
  injector.registerSingleton<PaqueteMenuBloc>(PaqueteMenuBloc(injector()));

  injector.registerSingleton<FacturaAPI>(FacturaAPI(injector()));
  injector.registerSingleton<AbstractFacturaRepository>(FacturaRepositoryImpl(injector()));
  injector.registerSingleton<DocumentoBloc>(DocumentoBloc(injector()));
  injector.registerSingleton<FormFacturaBloc>(FormFacturaBloc(injector(), injector()));
  injector.registerSingleton<ItemDocumentoBloc>(ItemDocumentoBloc(injector()));

  injector.registerSingleton<TipoImpuestoApi>(TipoImpuestoApi(injector()));
  injector.registerSingleton<AbstractTipoImpuestoRepository>(TipoImpuestoRepositoryImpl(injector()));
  injector.registerSingleton<TipoImpuestoBloc>(TipoImpuestoBloc(injector()));

  injector.registerSingleton<AccionDocumentoDB>(AccionDocumentoDB());
  injector.registerSingleton<AbstractAccionDocumentoRepository>(AccionDocumentoRepositoryDBImpl(injector()));
  injector.registerSingleton<AccionDocumentoBloc>(AccionDocumentoBloc(injector()));
}
