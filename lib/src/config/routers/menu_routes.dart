import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/views/menu_view.dart';

class MenuRoutes {
  static List<ShellRoute> getRoutesMenu() {
    final List<ShellRoute> routes = <ShellRoute>[];
    routes.add(routerMenu());
    return routes;
  }

  static ShellRoute routerMenu() {
    return ShellRoute(
      builder: (_, __, Widget child) => MenuLayout(child: child),
      routes: <RouteBase>[
        GoRoute(
          path: "/",
          builder: (_, __) => const MenuView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}
