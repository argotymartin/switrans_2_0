import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';

import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/ui/views/create/transaccion_contable_create_view.dart';
import 'package:switrans_2_0/src/packages/contabilidad/transaccion_contable/ui/views/search/transaccion_contable_search_view.dart';

class ContabilidadRoutes {
  static const String packagePath = "/contabilidad";

  static List<GoRoute> getRoutesContabilidad() {
    return <GoRoute>[
      ..._routerTransaccionContable(),
    ];
  }

  static List<GoRoute> _routerTransaccionContable() {
    const String modulePath = "transaccion_contable";
    return <GoRoute>[
      GoRoute(
        path: "$packagePath/$modulePath/registrar",
        builder: (BuildContext context, GoRouterState state) {
          context.read<TransaccionContableBloc>().request.clean();
          return const TransaccionContableCreateView();
        },
        redirect: ValidateRoutes.onValidateAuth,
      ),
      GoRoute(
        path: "$packagePath/$modulePath/buscar",
        builder: (BuildContext context, __) {
          context.read<TransaccionContableBloc>().request.clean();
          return const TransaccionContableSearchView();
        },
        redirect: ValidateRoutes.onValidateAuth,
      ),
    ];
  }
}
