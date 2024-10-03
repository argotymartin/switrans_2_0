import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/search/factura_search_view.dart';

class FinancieroRoutes {
  static const String packagePath = "/financiero";

  static List<ShellRoute> getRoutesFinaciero() {
    final List<ShellRoute> routes = <ShellRoute>[];
    routes.add(routerFactura());
    return routes;
  }

  static ShellRoute routerFactura() {
    const String modulePath = "factura";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<FacturaBloc>(
          create: (_) => FacturaBloc(injector())..add(const GetInitialFormFacturaEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            //context.read<FacturaBloc>().request.clean();
            return const FacturaCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            //context.read<FacturaBloc>().request.clean();
            return const FacturaSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}
