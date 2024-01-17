import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/modules/login/ui/blocs/usuario/usuario_bloc.dart';
import 'package:switrans_2_0/src/modules/login/ui/layouts/auth_layout.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/error.layout.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/views/menu_view.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/views/factura_edit_view.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/views/factura_search_view.dart';
import 'package:switrans_2_0/src/modules/shared/views/loading_view.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/blocs/filters_factura/filters_factura_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/views/factura_create_view.dart';

class AppRouter {
  static const root = "/";
  static const login = "/sign-in";
  static const factura = "/factura";
  static const notaDebito = "/notaDebito";
  static const notaCredito = "/notaCredito";
  bool isSignedIn = false;
  static final GoRouter router = GoRouter(
    initialLocation: "/factura/registrar",
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (_, __) => const AuthLayout(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MenuLayout(child: child);
        },
        routes: [
          GoRoute(
            path: root,
            builder: (_, GoRouterState state) => const MenuView(),
          ),
          GoRoute(
            path: "/factura/registrar",
            builder: (context, GoRouterState state) {
              context.read<FiltersFacturaBloc>().add(const ActiveteFiltersFacturaEvent());
              return BlocBuilder<FiltersFacturaBloc, FiltersFacturaState>(
                builder: (context, stateFactura) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: (stateFactura is FiltersFacturaInitialState) ? const FacturaCreateView() : const LoadingView(),
                  );
                },
              );
            },
          ),
          /*GoRoute(
            path: "/factura/registrar",
            builder: (_, __) => const FacturaCreateView(),
            redirect: onValidateAuth,
          ),*/
          GoRoute(
            path: "/factura/buscar",
            builder: (_, __) => const FacturaSearchView(),
            redirect: onValidateAuth,
          ),
          GoRoute(
            path: "/factura/editar",
            builder: (_, __) => const FacturaEditView(),
            redirect: onValidateAuth,
          ),
        ],
      ),
    ],
    errorBuilder: (_, state) => ErrorLayout(goRouterState: state),
  );

  static FutureOr<String?> onValidateAuth(BuildContext context, GoRouterState state) async {
    final bool isSignedIn = BlocProvider.of<UsuarioBloc>(context).state.isSignedIn;
    return isSignedIn ? state.path : login;
  }
}
