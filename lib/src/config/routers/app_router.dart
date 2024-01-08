import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/error.layout.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/views/menu_view.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/views/factura_view.dart';

class AppRouter {
  static const root = "/";
  static const factura = "/prefactura";
  static const notaDebito = "/notaDebito";
  static const notaCredito = "/notaCredito";

  static final GoRouter router = GoRouter(
    initialLocation: root,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          return MenuLayout(child: child);
        },
        routes: [
          GoRoute(
            path: root,
            builder: (_, GoRouterState state) {
              return const MenuView();
            },
          ),
          GoRoute(
            path: factura,
            builder: (_, GoRouterState state) {
              return const FacturaView();
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorLayout(),
  );
}
