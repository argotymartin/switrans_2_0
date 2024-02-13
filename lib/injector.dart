import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:switrans_2_0/src/globals/login/data/datasources/api/auth_pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/login/data/repositories/auth_repository_impl.dart';
import 'package:switrans_2_0/src/globals/login/domain/repositories/abstract_auth_repository.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/data/datasorces/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/globals/menu/data/repositories/modulo_repository_impl.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/datasorces/api/factura_api.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/repositories/factura_repository_impl.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/repositories/abstract_factura_repository.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<MenuBloc>(MenuBloc());
  injector.registerSingleton<ThemeCubit>(ThemeCubit());
  injector.registerSingleton<ItemFacturaBloc>(ItemFacturaBloc());

  injector.registerSingleton<AuthPocketbaseApi>(AuthPocketbaseApi(injector()));
  injector.registerSingleton<AbstractAuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<AuthBloc>(AuthBloc(injector()));

  injector.registerSingleton<PocketbaseAPI>(PocketbaseAPI(injector()));
  injector.registerSingleton<AbstractModuloRepository>(ModuloRespositoryImpl(injector()));
  injector.registerSingleton<ModuloBloc>(ModuloBloc(injector()));

  injector.registerSingleton<FacturaAPI>(FacturaAPI(injector()));
  injector.registerSingleton<AbstractFacturaRepository>(FacturaRepositoryImpl(injector()));
  injector.registerSingleton<FormFacturaBloc>(FormFacturaBloc(injector()));
  injector.registerSingleton<FacturaBloc>(FacturaBloc(injector()));
}
