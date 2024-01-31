import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/views/splash_view.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
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
        BlocProvider<FormularioFacturaCubit>(create: (_) => injector<FormularioFacturaCubit>()),
        BlocProvider<ItemFacturaBloc>(create: (_) => injector<ItemFacturaBloc>()),
        BlocProvider<AuthBloc>(create: (_) => injector()..add((const GetAuthEvent()))),
        BlocProvider<ModuloBloc>(create: (_) => injector()..add((const GetModuloEvent()))),
        BlocProvider<FacturaBloc>(create: (_) => injector()..add((const GetFacturaEvent()))),
        BlocProvider<FilterFacturaBloc>(create: (_) => injector()..add((const GetFilterFacturaEvent()))),
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
  bool _loading = true;
  bool isTokenValid = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  Future<void> _init() async {
    final authBloc = context.read<AuthBloc>();
    final moduloBloc = context.read<ModuloBloc>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token') ?? '';
    isTokenValid = await authBloc.onValidateToken(stringValue);
    if (isTokenValid) {
      moduloBloc.add(const ActiveteModuloEvent());
    }
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: _loading ? const SplashView() : const _BuildMaterialApp(),
    );
  }
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

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
