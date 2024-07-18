import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/create/accion_documento_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/search/accion_documento_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/create/modulo_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/search/modulo_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/views/create/paquete_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/views/search/paquete_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/views/create/servicio_empresarial_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/views/search/servicio_empresarial_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/views/create/tipo_impuesto_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/views/search/tipo_impuesto_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/views/create/transaccion_contable_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/views/search/transaccion_contable_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/create/unidad_negocio_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/search/unidad_negocio_search_view.dart';
import 'package:switrans_2_0/src/util/shared/views/splash_view.dart';

class MaestrosRoutes {
  static const String packagePath = "/maestros";

  static List<ShellRoute> getRoutesMaestros() {
    final List<ShellRoute> routes = <ShellRoute>[];
    routes.add(accionDocumentos());
    routes.add(routerTipoImpuesto());
    routes.add(routerServicioEmpresarial());
    routes.add(routerUnidadNegocio());
    routes.add(routerModulo());
    routes.add(routerPaquete());
    routes.add(routerTransaccionContable());
    return routes;
  }

  static ShellRoute accionDocumentos() {
    const String modulePath = "accion_documentos";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return FutureBuilder<void>(
          future: context.read<AccionDocumentoBloc>().onGetTipoDocumento(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MenuLayout(child: child);
            }
            return const MenuLayout(child: SplashView());
          },
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
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
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MenuLayout(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
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

  static ShellRoute routerServicioEmpresarial() {
    const String modulePath = "servicio_empresarial";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MenuLayout(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (_, __) => const ServicioEmpresarialCreateView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const ServicoEmpresarialSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerUnidadNegocio() {
    const String modulePath = "unidad_negocio";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return FutureBuilder<void>(
          future: context.read<UnidadNegocioBloc>().onGetEmpresas(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MenuLayout(child: child);
            }
            return const MenuLayout(child: SplashView());
          },
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (_, __) => const UnidadNegocioCreateView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const UnidadNegocioSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerModulo() {
    const String modulePath = "modulo";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return FutureBuilder<void>(
          future: context.read<ModuloBloc>().onGetPaquetes(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MenuLayout(child: child);
            }
            return const MenuLayout(child: SplashView());
          },
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            return const ModuloCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const ModuloSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerPaquete() {
    const String modulePath = "paquete";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MenuLayout(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            return const PaqueteCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const PaqueteSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
  static ShellRoute routerTransaccionContable() {
    const String modulePath = "transaccion_contable";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return FutureBuilder<void>(
          future: context.read<TransaccionContableBloc>().onGetImpuestos(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MenuLayout(child: child);
            }
            return const MenuLayout(child: SplashView());
          },
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            return const TransaccionContableCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,

        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const TransaccionContableSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerPagina() {
    const String modulePath = "pagina";

    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return FutureBuilder<void>(
          future: context.read<PaginaBloc>().onGetModulos(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              context.read<PaginaBloc>().add(const InitialPaginaEvent());
              return MenuLayout(child: child);
            }
            return const MenuLayout(child: SplashView());
          },
        );
      },

      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            return const PaginaCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (_, __) => const PaginaSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}


