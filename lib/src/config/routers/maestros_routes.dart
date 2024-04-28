import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/create/accion_documento_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/search/accion_documento_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/views/create/tipo_impuesto_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/views/search/tipo_impuesto_search_view.dart';
import 'package:switrans_2_0/src/util/shared/views/splash_view.dart';

import '../../packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';

class MaestrosRoutes {
  static const String packagePath = "/maestros";

  static List<ShellRoute> getRoutesMaestros() {
    List<ShellRoute> routes = [];
    routes.add(accionDocumentos());
    routes.add(routerTipoImpuesto());
    return routes;
  }

  static ShellRoute accionDocumentos() {
    const String modulePath = "accion_documentos";
    return ShellRoute(
      builder: (context, state, child) {
        return FutureBuilder(
          future: context.read<AccionDocumentoBloc>().onGetTipoDocumento(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MenuLayout(child: child);
            }
            return const MenuLayout(child: SplashView());
          },
        );
      },
      routes: [
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (context, GoRouterState state) {
            return const AccionDocumentoCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const AccionDocumentoSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerTipoImpuesto() {
    const String modulePath = "tipo_impuesto";
    return ShellRoute(
      builder: (context, state, child) {
        return MenuLayout(child: child);
      },
      routes: [
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (context, GoRouterState state) {
            return const TipoImpuestoCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const TipoImpuestoSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}
