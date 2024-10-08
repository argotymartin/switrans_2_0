import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/create/accion_documento_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/views/search/accion_documento_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/ui/blocs/departamento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/ui/views/create/departamento_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/ui/views/search/departamento_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/create/modulo_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/views/search/modulo_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/blocs/municipio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/views/create/municipio_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/views/search/municipio_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/views/create/pagina_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/views/search/pagina_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/ui/blocs/pais_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/ui/views/create/pais_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/ui/views/search/pais_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/views/create/paquete_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/views/search/paquete_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/blocs/resolucion_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/views/create/resolucion_create_view.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/views/search/resolucion_search_view.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
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


class MaestrosRoutes {
  static const String packagePath = "/maestros";

  static List<ShellRoute> getRoutesMaestros() {
    final List<ShellRoute> routes = <ShellRoute>[];
    routes.add(accionDocumentos());
    routes.add(routerDepartamento());
    routes.add(routerModulo());
    routes.add(routerTipoImpuesto());
    routes.add(routerServicioEmpresarial());
    routes.add(routerUnidadNegocio());
    routes.add(routerPaquete());
    routes.add(routerTransaccionContable());
    routes.add(routerPagina());
    routes.add(routerResolucion());
    routes.add(routerPais());
    routes.add(routerMunicipio());
    return routes;
  }

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
            context.read<AccionDocumentoBloc>().request.clean();
            return const AccionDocumentoCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<AccionDocumentoBloc>().request.clean();
            return const AccionDocumentoSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerDepartamento() {
    const String modulePath = "departamento";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<DepartamentoBloc>(
          create: (_) => DepartamentoBloc(injector())..add(const InitialDepartamentoEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<DepartamentoBloc>().request.clean();
            return const DepartamentoCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<DepartamentoBloc>().request.clean();
            return const DepartamentoSearchView();
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
            context.read<ModuloBloc>().request.clean();
            return const ModuloCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            context.read<ModuloBloc>().request.clean();
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
        return BlocProvider<TipoImpuestoBloc>(
          create: (_) => TipoImpuestoBloc(injector())..add(const InitializationTipoImpuestoEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
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
      ],
    );
  }

  static ShellRoute routerServicioEmpresarial() {
    const String modulePath = "servicio_empresarial";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<ServicioEmpresarialBloc>(
          create: (_) => ServicioEmpresarialBloc(injector())..add(const InitializationServicioEmpresarialEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<ServicioEmpresarialBloc>().request.clean();
            return const ServicioEmpresarialCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            context.read<ServicioEmpresarialBloc>().request.clean();
            return const ServicoEmpresarialSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerUnidadNegocio() {
    const String modulePath = "unidad_negocio";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<UnidadNegocioBloc>(
          create: (_) => UnidadNegocioBloc(injector())..add(const InitializationUnidadNegocioEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<UnidadNegocioBloc>().request.clean();
            return const UnidadNegocioCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            context.read<UnidadNegocioBloc>().request.clean();
            return const UnidadNegocioSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerMunicipio() {
    const String modulePath = "municipio";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<MunicipioBloc>(
          create: (_) => MunicipioBloc(injector())..add(const InitialMunicipioEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<MunicipioBloc>().request.clean();
            return const MunicipioCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<MunicipioBloc>().request.clean();
            return const MunicipioSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerPais() {
    const String modulePath = "pais";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<PaisBloc>(
          create: (_) => PaisBloc(injector())..add(const InitialPaisEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<PaisBloc>().request.clean();
            return const PaisCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<PaisBloc>().request.clean();
            return const PaisSearchView();
          },
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
            context.read<PaqueteBloc>().request.clean();
            return const PaqueteCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<PaqueteBloc>().request.clean();
            return const PaqueteSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerTransaccionContable() {
    const String modulePath = "transaccion_contable";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<TransaccionContableBloc>(
          create: (_) => TransaccionContableBloc(injector())..add(const InitializationTransaccionContableEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
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
            context.read<PaginaBloc>().request.clean();
            return const PaginaCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            context.read<PaginaBloc>().request.clean();
            return const PaginaSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }

  static ShellRoute routerResolucion() {
    const String modulePath = "resolucion";
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider<ResolucionBloc>(
          create: (_) => ResolucionBloc(injector())..add(const InitializationResolucionEvent()),
          child: MenuLayout(child: child),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: "$packagePath/$modulePath/registrar",
          builder: (BuildContext context, GoRouterState state) {
            context.read<ResolucionBloc>().request.clean();
            return const ResolucionCreateView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "$packagePath/$modulePath/buscar",
          builder: (BuildContext context, __) {
            context.read<ResolucionBloc>().request.clean();
            return const ResolucionSearchView();
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}
