import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:switrans_2_0/src/modules/login/data/datasources/api/usuario_pocketbase_api.dart';
import 'package:switrans_2_0/src/modules/login/data/repositories/usuario_repository_impl.dart';
import 'package:switrans_2_0/src/modules/login/domain/repositories/abstract_usuario_repository.dart';
import 'package:switrans_2_0/src/modules/login/ui/blocs/usuario/usuario_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/data/datasorces/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/modules/menu/data/repositories/modulo_repository_impl.dart';
import 'package:switrans_2_0/src/modules/menu/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/modules/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/datasorces/api/factura_api.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/repositories/factura_repository_impl.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/repositories/abstract_factura_repository.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<UsuarioPocketbaseApi>(UsuarioPocketbaseApi(injector()));
  injector.registerSingleton<AbstractUsuarioRepository>(UsuarioRepositoryImpl(injector()));
  injector.registerSingleton<UsuarioBloc>(UsuarioBloc(injector()));

  injector.registerSingleton<PocketbaseAPI>(PocketbaseAPI(injector()));
  injector.registerSingleton<AbstractModuloRepository>(ModuloRespositoryImpl(injector()));
  injector.registerSingleton<ModuloBloc>(ModuloBloc(injector()));

  injector.registerSingleton<FacturaAPI>(FacturaAPI(injector()));
  injector.registerSingleton<AbstractFacturaRepository>(FacturaRepositoryImpl(injector()));
  injector.registerSingleton<FacturaBloc>(FacturaBloc(injector()));
  injector.registerSingleton<FilterFacturaBloc>(FilterFacturaBloc(injector()));
}
