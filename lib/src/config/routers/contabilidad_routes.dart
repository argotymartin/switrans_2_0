import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/ui/blocs/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/ui/views/create/tipo_impuesto_create_view.dart';
import 'package:switrans_2_0/src/packages/contabilidad/tipo_impuesto/ui/views/search/tipo_impuesto_search_view.dart';

class ContabilidadRoutes {
  static const String packagePath = "/contabilidad";

  static List<GoRoute> getRoutesContabilidad() {
    return <GoRoute>[
      ..._routerTipoImpuesto(),
    ];
  }

  static List<GoRoute> _routerTipoImpuesto() {
    const String modulePath = "tipo_impuesto";
    return <GoRoute>[
      GoRoute(
        path: "$packagePath/$modulePath/registrar",
        builder: (BuildContext context, GoRouterState state) {
          context.read<TipoImpuestoBloc>().request.clean();
          return const TipoImpuestoCreateView();
        },
        redirect: ValidateRoutes.onValidateAuth,
      ),
      GoRoute(
        path: "$packagePath/$modulePath/buscar",
        builder: (BuildContext context, __) {
          context.read<TipoImpuestoBloc>().request.clean();
          return const TipoImpuestoSearchView();
        },
        redirect: ValidateRoutes.onValidateAuth,
      ),
    ];
  }
}