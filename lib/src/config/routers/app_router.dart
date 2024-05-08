import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/financiero_routes.dart';
import 'package:switrans_2_0/src/config/routers/maestros_routes.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class AppRouter {
  static String initialRoute = "/";
  static const String login = "/sign-in";

  bool isSignedIn = false;
  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (_, __) => const AuthLayout(),
      ),
      ...FinancieroRoutes.getRoutesFinaciero(),
      ...MaestrosRoutes.getRoutesMaestros(),
    ],
    errorBuilder: (_, GoRouterState state) => ErrorLayout(goRouterState: state),
  );
}
