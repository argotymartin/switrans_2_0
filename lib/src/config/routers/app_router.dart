import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/src/modules/login/ui/layouts/auth_layout.dart';
import 'package:switrans_2_0/src/modules/menu/ui/menu_ui.dart';
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
            pageBuilder: (context, GoRouterState state) {
              context.read<FilterFacturaBloc>().add(const ActiveteFilterFacturaEvent());
              return MaterialPage(
                child: BlocBuilder<FilterFacturaBloc, FilterFacturaState>(
                  builder: (context, stateFactura) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: (stateFactura is FiltersFacturaInitialState) ? const FacturaCreateView() : const LoadingView(),
                    );
                  },
                ),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token') ?? '';
    //final bool isSignedIn = BlocProvider.of<UsuarioBloc>(context).state.isSignedIn;
    return stringValue != "" ? state.path : login;
  }
}
