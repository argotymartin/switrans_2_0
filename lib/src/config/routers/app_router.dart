import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/financiero_routes.dart';
import 'package:switrans_2_0/src/config/routers/maestros_routes.dart';
import 'package:switrans_2_0/src/globals/login/ui/layouts/auth_layout.dart';
import 'package:switrans_2_0/src/globals/login/ui/layouts/views/token_expired_view.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class AppRouter {
  static const String login = "/sign-in";
  static const String tokenExpired = "/token-expired";
  static const String loading = "/loading";

  bool isSignedIn = false;
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    //redirect: ValidateRoutes.onValidateAuth,
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (_, __) => const AuthLayout(),
      ),
      GoRoute(
        path: tokenExpired,
        builder: (_, __) => const TokenExpired(),
      ),
      GoRoute(
        path: loading,
        builder: (_, __) => const LoadingView(),
      ),
      ...FinancieroRoutes.getRoutesFinaciero(),
      ...MaestrosRoutes.getRoutesMaestros(),
    ],
    errorBuilder: (_, GoRouterState state) => ErrorLayout(goRouterState: state),
  );
}
