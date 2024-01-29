import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/views/loading_view.dart';

class AppRouter {
  static const root = "/";
  static const login = "/sign-in";
  static const factura = "/factura";
  static const notaDebito = "/notaDebito";
  static const notaCredito = "/notaCredito";
  bool isSignedIn = false;
  static final GoRouter router = GoRouter(
    initialLocation: "/factura/registrar",
    debugLogDiagnostics: true,
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
              context.read<FilterFacturaBloc>().add(const ActiveteFilterFacturaEvent());
              return BlocBuilder<FilterFacturaBloc, FilterFacturaState>(
                builder: (context, stateFactura) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: (stateFactura is FiltersFacturaInitialState) ? const FacturaCreateView() : const LoadingView(),
                  );
                },
              );
            },
            redirect: onValidateAuth,
          ),
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
    final moduloBloc = context.read<ModuloBloc>();
    final authBloc = context.read<AuthBloc>();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token') ?? '';
    //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJ5ZmtieTdiNG84N3RrOGwiLCJleHAiOjE3MDY1NTI3MzcsImlkIjoiMHNzdDB0a3pwZDMyN2JkIiwidHlwZSI6ImF1dGhSZWNvcmQifQ.BqKKZKSAA1g7esh47sJkUzUSAvtJVqLc0VYptBq8Y6s"

    final isTokenValid = await authBloc.onValidateToken(stringValue);
    if (isTokenValid) {
      int lengthModulos = moduloBloc.state.modulos.length;
      if (lengthModulos < 1) {
        moduloBloc.add(const ActiveteModuloEvent());
      }
    }
    return isTokenValid ? state.path : login;
  }
}
