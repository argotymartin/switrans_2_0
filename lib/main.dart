import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
//import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nested/nested.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

Future<void> main() async {
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await initializeDependencies();
  initializeConfig();
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
        BlocProvider<AuthBloc>(create: (_) => injector<AuthBloc>()),
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
    final ThemeState theme = context.watch<ThemeCubit>().state;

    return MaterialApp.router(
      title: 'Switrans 2.0',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme(theme.color!, theme.themeMode!).getTheme(context),
    );
  }
}
