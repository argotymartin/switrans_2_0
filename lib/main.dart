import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/util/simple_bloc_observer.dart';

Future<void> main() async {
  //usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuBloc>(create: (_) => injector<MenuBloc>()),
        BlocProvider<ThemeCubit>(create: (_) => injector<ThemeCubit>()),
        BlocProvider<FormFacturaBloc>(create: (_) => injector<FormFacturaBloc>()),
        BlocProvider<ItemDocumentoBloc>(create: (_) => injector<ItemDocumentoBloc>()),
        BlocProvider<TipoImpuestoBloc>(create: (_) => injector<TipoImpuestoBloc>()),
        BlocProvider<AuthBloc>(create: (_) => injector()..add((const GetAuthEvent()))),
        BlocProvider<PaqueteMenuBloc>(create: (_) => injector()..add((const GetPaqueteMenuEvent()))),
        BlocProvider<DocumentoBloc>(create: (_) => injector()..add((const GetFacturaEvent()))),
        BlocProvider<AccionDocumentoBloc>(create: (_) => injector<AccionDocumentoBloc>()),
        BlocProvider<ServicioEmpresarialBloc>(create: (_) => injector<ServicioEmpresarialBloc>()),
      ],
      child: const MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  bool isTokenValid = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  Future<void> _init() async {
    final authBloc = context.read<AuthBloc>();
    final paqueteMenuBloc = context.read<PaqueteMenuBloc>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token') ?? '';
    isTokenValid = await authBloc.onValidateToken(stringValue);
    if (isTokenValid) {
      paqueteMenuBloc.add(const ActivetePaqueteMenuEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      child: _BuildMaterialApp(),
    );
  }
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;
    return MaterialApp.router(
      title: 'Switrans 2.0',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme(color: theme.color).getTheme(context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
      ],
    );
  }
}
