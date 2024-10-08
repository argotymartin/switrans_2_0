import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/views/menu_view.dart';

class MenuRoutes {
  static List<GoRoute> getRoutesMenu() {
    final List<GoRoute> routes = <GoRoute>[];
    routes.add(routerMenu());
    return routes;
  }

  static GoRoute routerMenu() {
    return GoRoute(
      path: "/",
      builder: (_, __) => const MenuView(),
      redirect: ValidateRoutes.onValidateAuth,
    );
  }
}
