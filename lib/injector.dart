import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:switrans_2_0/src/modules/menu/data/datasorces/api/pocketbase_api.dart';
import 'package:switrans_2_0/src/modules/menu/data/repositories/modulo_repository_impl.dart';
import 'package:switrans_2_0/src/modules/menu/domain/repositories/abstract_modulo_repository.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<PocketbaseAPI>(PocketbaseAPI(injector()));
  injector.registerSingleton<AbstractModuloRepository>(ModuloRespositoryImpl(injector()));
  injector.registerSingleton<ModuloBloc>(ModuloBloc(injector()));
}
