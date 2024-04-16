import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/validate_routes.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/menu_layout.dart';
import 'package:switrans_2_0/src/globals/menu/ui/layouts/views/menu_view.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FinancieroRoutes {
  static const String packagePath = "finaciero";

  static List<ShellRoute> getRoutesFinaciero() {
    List<ShellRoute> routes = [];
    routes.add(routerFactura());
    return routes;
  }

  static ShellRoute routerFactura() {
    const String modulePath = "factura";
    return ShellRoute(
      builder: (context, state, child) {
        return MenuLayout(child: child);
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (_, GoRouterState state) => const MenuView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "/$packagePath/$modulePath/registrar",
          builder: (context, GoRouterState state) {
            context.read<FormFacturaBloc>().add(const GetFormFacturaEvent());
            return BlocConsumer<FormFacturaBloc, FormFacturaState>(
              listener: (context, state) {
                if (state is FormFacturaErrorState) ErrorDialog.showDioException(context, state.exception!);
              },
              builder: (context, stateFactura) {
                return (stateFactura is FormFacturaLoadingState) ? const LoadingView() : const FacturaCreateView();
              },
            );
          },
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "/$packagePath/$modulePath/buscar",
          builder: (_, __) => const FacturaSearchView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
        GoRoute(
          path: "/$packagePath/$modulePath/editar",
          builder: (_, __) => const FacturaEditView(),
          redirect: ValidateRoutes.onValidateAuth,
        ),
      ],
    );
  }
}
