import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/modules/login/ui/blocs/usuario/usuario_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

Future<void> main() async {
  //usePathUrlStrategy();
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
        BlocProvider<ItemFacturaBloc>(create: (_) => ItemFacturaBloc()),
        BlocProvider<UsuarioBloc>(create: (_) => injector()..add((const GetUsuarioEvent()))),
        BlocProvider<ModuloBloc>(create: (_) => injector()..add((GetModuloEvent()))),
        BlocProvider<FacturaBloc>(create: (_) => injector()..add((const GetFacturaEvent()))),
        BlocProvider<FilterFacturaBloc>(create: (_) => injector()..add((const GetFilterFacturaEvent()))),
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Español
      ],
    );
  }
}
