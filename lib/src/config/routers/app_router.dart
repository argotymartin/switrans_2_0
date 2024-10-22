import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/config/routers/financiero_routes.dart';
import 'package:switrans_2_0/src/config/routers/maestros_routes.dart';
import 'package:switrans_2_0/src/config/routers/menu_routes.dart';
import 'package:switrans_2_0/src/globals/login/ui/layouts/auth_layout.dart';
import 'package:switrans_2_0/src/globals/login/ui/layouts/views/error_connection_view.dart';
import 'package:switrans_2_0/src/globals/login/ui/layouts/views/token_expired_view.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/ui/blocs/accion_documentos/accion_documento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/departamento/ui/blocs/departamento_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/modulo/ui/blocs/modulo_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/blocs/municipio_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pais/ui/blocs/pais_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/paquete/ui/blocs/paquete_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/resolucion/ui/blocs/resolucion_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/ui/blocs/servicio_empresarial/servicio_empresarial_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/tipo_impuesto/ui/blocs/tipo_impuesto/tipo_impuesto_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/ui/blocs/transaccion_contable/transaccion_contable_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/ui/blocs/unidad_negocio_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class AppRouter {
  static const String login = "/sign-in";
  static const String loading = "/loading";
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  bool isSignedIn = false;
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    //redirect: ValidateRoutes.onValidateAuth,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (_, __) => const AuthLayout(),
      ),
      GoRoute(
        path: "/token-expired",
        builder: (_, __) => const TokenExpired(),
      ),
      GoRoute(
        path: "/error-connection",
        builder: (_, __) => const ErrorConnectionScreen(),
      ),
      GoRoute(
        path: "/loading",
        builder: (_, __) => const LoadingView(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MultiBlocProvider(
            providers: <SingleChildWidget>[
              BlocProvider<FacturaBloc>(create: (_) => injector<FacturaBloc>()),
              BlocProvider<AccionDocumentoBloc>(
                create: (_) => injector<AccionDocumentoBloc>()..add(const InitializationAccionDocumentoEvent()),
              ),
              BlocProvider<DepartamentoBloc>(
                create: (_) => injector<DepartamentoBloc>()..add(const InitialDepartamentoEvent()),
              ),
              BlocProvider<ModuloBloc>(
                create: (_) => injector<ModuloBloc>()..add(const InitializationModuloEvent()),
              ),
              BlocProvider<TipoImpuestoBloc>(
                create: (_) => injector<TipoImpuestoBloc>()..add(const InitializationTipoImpuestoEvent()),
              ),
              BlocProvider<ServicioEmpresarialBloc>(
                create: (_) => injector<ServicioEmpresarialBloc>()..add(const InitializationServicioEmpresarialEvent()),
              ),
              BlocProvider<UnidadNegocioBloc>(
                create: (_) => injector<UnidadNegocioBloc>()..add(const InitialUnidadNegocioEvent()),
              ),
              BlocProvider<PaisBloc>(
                create: (_) => injector<PaisBloc>()..add(const InitialPaisEvent()),
              ),
              BlocProvider<PaqueteBloc>(
                create: (_) => injector<PaqueteBloc>()..add(const InitialPaqueteEvent()),
              ),
              BlocProvider<TransaccionContableBloc>(
                create: (_) => injector<TransaccionContableBloc>()..add(const InitializationTransaccionContableEvent()),
              ),
              BlocProvider<PaginaBloc>(
                create: (_) => injector<PaginaBloc>()..add(const InitialPaginaEvent()),
              ),
              BlocProvider<ResolucionBloc>(
                create: (_) => injector<ResolucionBloc>()..add(const InitializationResolucionEvent()),
              ),
              BlocProvider<MunicipioBloc>(
                create: (_) => injector<MunicipioBloc>()..add(const InitialMunicipioEvent()),
              ),
            ],
            child: MenuLayout(child: child),
          );
        },
        routes: <RouteBase>[
          ...MenuRoutes.getRoutesMenu(),
          ...FinancieroRoutes.getRoutesFinanciero(),
          ...MaestrosRoutes.getRoutesMaestros(),
        ],
      ),
    ],
    errorBuilder: (_, GoRouterState state) => ErrorLayout(goRouterState: state),
  );
}
