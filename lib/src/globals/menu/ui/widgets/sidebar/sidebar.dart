import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/footer_sidebar.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/search_modulo.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        return state.isOpenMenu
            ? Column(
                children: <Widget>[
                  Container(
                    width: state.isMinimize ? 80 : kWidthSidebar,
                    height: size.height * 0.92,
                    decoration: buildBoxDecoration(context),
                    child: Theme(
                      data: ThemeData(
                        scrollbarTheme: ScrollbarThemeData(
                          thickness: WidgetStateProperty.all(8.0),
                        ),
                      ),
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        children: <Widget>[
                          LogoSidebar(isMenuIcon: state.isMinimize),
                          ProfileSidebar(isMenuIcon: state.isMinimize),
                          state.isMinimize ? const SizedBox() : const SizedBox(height: 16),
                          state.isMinimize ? const SizedBox() : const SearchModulo(),
                          state.isMinimize ? const SizedBox() : const SizedBox(height: 16),
                          state.isMinimize ? const SizedBox() : const TextSeparatorSidebar(text: 'Paquetes'),
                          BlocBuilder<MenuSidebarBloc, MenuSidebarState>(
                            builder: (BuildContext context, MenuSidebarState stateModulo) {
                              final List<PaquetesSidebar> paquetesSidebar = <PaquetesSidebar>[];
                              for (final PaqueteMenu paquete in stateModulo.paquetes) {
                                paquetesSidebar.add(
                                  PaquetesSidebar(
                                    paquete: paquete,
                                    isMimimize: state.isMinimize,
                                  ),
                                );
                              }
                              return Column(children: paquetesSidebar);
                            },
                          ),
                          state.isMinimize ? const SizedBox() : const SizedBox(height: 50),
                          state.isMinimize ? const SizedBox() : const TextSeparatorSidebar(text: 'Exit'),
                          Padding(
                            padding: state.isMinimize ? const EdgeInsets.all(4.0) : const EdgeInsets.all(8.0),
                            child: OutlinedButton.icon(
                              label: state.isMinimize ? const SizedBox() : const Text("Salir", style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                context.read<AuthBloc>().onLogoutAuthEvent();
                                context.go(AppRouter.login);
                              },
                              icon: const Icon(
                                Icons.logout_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FooterSidebar(isMinimize: state.isMinimize),
                ],
              )
            : const SizedBox();
      },
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: <Color>[
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
        ],
      ),
    );
  }
}
