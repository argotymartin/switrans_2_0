import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/config/theme/app_theme.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/menu/menu_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/blocs/factura/factura_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/blocs/filters_factura/filters_factura_bloc.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuBloc>(create: (_) => MenuBloc()),
        BlocProvider<ModuloBloc>(create: (_) => injector()..add((GetModuloEvent()))),
        BlocProvider<FacturaBloc>(create: (_) => injector()..add((const GetFacturaEvent()))),
        BlocProvider<FiltersFacturaBloc>(create: (_) => injector()..add((const GetFiltersFacturaEvent()))),
      ],
      child: const MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Switrans 2.0',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme().getTheme(context),
    );
  }
}
