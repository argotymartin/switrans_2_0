import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/create/accion_documento_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/search/accion_documento_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/create/modulo_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/search/modulo_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/views/create/pagina_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/views/search/pagina_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/views/create/paquete_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/views/search/paquete_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/views/create/servicio_empresarial_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/views/search/servicio_empresarial_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/views/create/tipo_impuesto_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/views/search/tipo_impuesto_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/views/create/transaccion_contable_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/views/search/transaccion_contable_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/create/unidad_negocio_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/views/search/unidad_negocio_search_view.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';

class MaestrosRoutes {
  static const String packagePath = "/maestros";

  static List<ShellRoute> getRoutesMaestros() {
    final List<ShellRoute> routes = <ShellRoute>[];
    routes.add(accionDocumentos());
    routes.add(routerModulo());
    routes.add(routerTipoImpuesto());
    routes.add(routerServicioEmpresarial());
    routes.add(routerUnidadNegocio());
    routes.add(routerPaquete());
    routes.add(routerTransaccionContable());
    routes.add(routerPagina());
    return routes;
  }

  //  context.read<AccionDocumentoBloc>().onGetTipoDocumento(),
  static ShellRoute accionDocumentos() {
    const String modulePath = "accion_documentos";

    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<AccionDocumentoBloc>(
          create: (_) => AccionDocumentoBloc(injector())..add(const InitializationAccionDocumentoEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            if (Preferences.isResetForm) {
              context.read<AccionDocumentoBloc>().add(const CleanFormAccionDocumentoEvent());
            }
            return const AccionDocumentoCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            if (Preferences.isResetForm) {
              context.read<AccionDocumentoBloc>().add(const CleanFormAccionDocumentoEvent());
            }

            return const AccionDocumentoSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerModulo() {
    const String modulePath = "modulo";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<ModuloBloc>(
          create: (_) => ModuloBloc(injector())..add(const InitializationModuloEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            if (Preferences.isResetForm) {
              context.read<ModuloBloc>().add(const CleanFormModuloEvent());
            }
            return const ModuloCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            if (Preferences.isResetForm) {
              context.read<ModuloBloc>().add(const CleanFormModuloEvent());
            }
            return const ModuloSearchView();
          },
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
            if (Preferences.isResetForm) {
              context.read<TipoImpuestoBloc>().add(const CleanFormTipoImpuestoEvent());
            }
            return const TipoImpuestoCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            if (Preferences.isResetForm) {
              context.read<TipoImpuestoBloc>().add(const CleanFormTipoImpuestoEvent());
            }
            return const TipoImpuestoSearchView();
          },
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

  static ShellRoute routerPaquete() {
    const String modulePath = "paquete";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<PaqueteBloc>(
          create: (_) => PaqueteBloc(injector())..add(const InitialPaqueteEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            if (Preferences.isResetForm) {
              context.read<PaqueteBloc>().add(const InitialPaqueteEvent());
            }
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
        return BlocProvider<PaginaBloc>(
          create: (_) => PaginaBloc(injector())..add(const InitialPaginaEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            if (Preferences.isResetForm) {
              context.read<PaginaBloc>().add(const CleanFormPaginaEvent());
            }
            return const PaginaCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            if (Preferences.isResetForm) {
              context.read<PaginaBloc>().add(const CleanFormPaginaEvent());
            }
            return const PaginaSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}
