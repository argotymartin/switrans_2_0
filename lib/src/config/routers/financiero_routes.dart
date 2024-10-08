import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/search/factura_search_view.dart';

class FinancieroRoutes {
  static const String packagePath = "/financiero";

  static List<GoRoute> getRoutesFinanciero() {
    return <GoRoute>[
      ..._routerFactura(),
    ];
  }

  static List<GoRoute> _routerFactura() {
    const String modulePath = "factura";
    return <GoRoute>[
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
    ];
  }
}
