import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';
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
  static const factura = "/factura";
  static const notaDebito = "/notaDebito";
  static const notaCredito = "/notaCredito";

  static final GoRouter router = GoRouter(
    initialLocation: root,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          context.read<ModuloBloc>().add(const ActiveteModuloEvent());
          context.read<FiltersFacturaBloc>().add(const ActiveteFiltersFacturaEvent());
          return MenuLayout(child: child);
        },
        routes: [
          GoRoute(
            path: root,
            builder: (_, GoRouterState state) => const MenuView(),
          ),
          GoRoute(
            path: factura,
            builder: (context, GoRouterState state) {
              return BlocBuilder<FiltersFacturaBloc, FiltersFacturaState>(
                builder: (context, state) {
                  if (state is FiltersFacturaInitialState) {
                    return const FacturaCreateView();
                  }
                  return const LoadingView();
                },
              );
            },
          ),
          GoRoute(
            path: "/factura/registrar",
            builder: (_, __) => const FacturaCreateView(),
          ),
          GoRoute(
            path: "/factura/buscar",
            builder: (_, __) => const FacturaSearchView(),
          ),
          GoRoute(
            path: "/factura/editar",
            builder: (_, __) => const FacturaEditView(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorLayout(),
  );
}
