import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/modules/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/maestro/tipo_impuesto/ui/views/create/tipo_impuesto_create_view.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AppRouter {
  static String initialRoute = "/";
  static const root = "/";
  static const login = "/sign-in";

  bool isSignedIn = false;
  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (_, __) => const AuthLayout(),
      ),
      routerFactura(),
      routerTipoImpuesto(),
    ],
    errorBuilder: (_, state) => ErrorLayout(goRouterState: state),
  );

  static ShellRoute routerFactura() {
    return ShellRoute(
      builder: (context, state, child) {
        return MenuLayout(child: child);
      },
      routes: [
        GoRoute(
          path: root,
          builder: (_, GoRouterState state) => const MenuView(),
          redirect: onValidateAuth,
        ),
        GoRoute(
          path: "/factura/registrar",
          builder: (context, GoRouterState state) {
            context.read<FormFacturaBloc>().add(const GetFormFacturaEvent());
            return BlocConsumer<FormFacturaBloc, FormFacturaState>(
              listener: (context, state) {
                if (state is FormFacturaErrorState) {
                  ErrorDialog.showErrorDioException(context, state.exception!);
                }
              },
              builder: (context, stateFactura) {
                return (stateFactura is FormFacturaLoadingState) ? const LoadingView() : const FacturaCreateView();
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
    );
  }

  static ShellRoute routerTipoImpuesto() {
    return ShellRoute(
      builder: (context, state, child) {
        return MenuLayout(child: child);
      },
      routes: [
        GoRoute(
          path: root,
          builder: (_, GoRouterState state) => const MenuView(),
          redirect: onValidateAuth,
        ),
        GoRoute(
          path: "/tipo_impuesto/registrar",
          builder: (context, GoRouterState state) {
            return const TipoImpuestoCreateView();
          },
          redirect: onValidateAuth,
        ),
        GoRoute(
          path: "/tipo_impuesto/buscar",
          builder: (_, __) => const FacturaSearchView(),
          redirect: onValidateAuth,
        ),
        GoRoute(
          path: "/tipo_impuesto/editar",
          builder: (_, __) => const FacturaEditView(),
          redirect: onValidateAuth,
        ),
      ],
    );
  }

  static FutureOr<String?> onValidateAuth(BuildContext context, GoRouterState state) async {
    final moduloBloc = context.read<ModuloBloc>();
    final authBloc = context.read<AuthBloc>();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token') ?? '';
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
