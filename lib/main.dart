import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nested/nested.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';

Future<void> main() async {
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await initializeDependencies();
  //Bloc.observer = SimpleBlocObserver();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<MenuBloc>(create: (_) => injector<MenuBloc>()),
        BlocProvider<ThemeCubit>(create: (_) => injector<ThemeCubit>()),
        BlocProvider<FormFacturaBloc>(create: (_) => injector<FormFacturaBloc>()),
        BlocProvider<ItemDocumentoBloc>(create: (_) => injector<ItemDocumentoBloc>()),
        BlocProvider<TipoImpuestoBloc>(create: (_) => injector<TipoImpuestoBloc>()),
        BlocProvider<AuthBloc>(create: (_) => injector()..add((const GetAuthEvent()))),
        BlocProvider<MenuSidebarBloc>(create: (_) => injector<MenuSidebarBloc>()),
        BlocProvider<ServicioEmpresarialBloc>(create: (_) => injector<ServicioEmpresarialBloc>()),
        BlocProvider<UnidadNegocioBloc>(create: (_) => injector<UnidadNegocioBloc>()),
        BlocProvider<TransaccionContableBloc>(create: (_) => injector<TransaccionContableBloc>()),
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
    final AuthBloc authBloc = context.read<AuthBloc>();
    final MenuSidebarBloc paqueteMenuBloc = context.read<MenuSidebarBloc>();
    isTokenValid = await authBloc.onValidateToken();
    if (isTokenValid) {
      paqueteMenuBloc.add(const ActiveteMenuSidebarEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      child: _BuildMaterialApp(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isTokenValid', isTokenValid));
  }
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

  @override
  Widget build(BuildContext context) {
    final ThemeState theme = context.watch<ThemeCubit>().state;
    return MaterialApp.router(
      title: 'Switrans 2.0',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme(theme.color!, theme.themeMode!).getTheme(context),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('es', 'ES'),
      ],
    );
  }
}
