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
    if (size.width <= 480) {
      context.read<MenuBloc>().add(const BlockedMenuEvent(true));
    } else if (size.width <= 960) {
      context.read<MenuBloc>().add(const MinimizedMenuEvent(true));
    } else {
      context.read<MenuBloc>().add(const ExpandedMenuEvent(true));
    }

    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        if (state.isOpenMenu) {
          return const SidebarExpanded();
        } else if (state.isMinimize) {
          return const SidebarMimimized();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class SidebarExpanded extends StatelessWidget {
  const SidebarExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: kWidthSidebar,
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
                const LogoSidebar(isMenuIcon: false),
                const ProfileSidebar(isMenuIcon: false),
                const SizedBox(height: 16),
                const SearchModulo(),
                const SizedBox(height: 16),
                const TextSeparatorSidebar(text: 'Paquetes'),
                BlocBuilder<MenuSidebarBloc, MenuSidebarState>(
                  builder: (BuildContext context, MenuSidebarState stateModulo) {
                    final List<PaquetesSidebar> paquetesSidebar = <PaquetesSidebar>[];
                    for (final PaqueteMenu paquete in stateModulo.paquetes) {
                      paquetesSidebar.add(
                        PaquetesSidebar(
                          paquete: paquete,
                        ),
                      );
                    }
                    return Column(children: paquetesSidebar);
                  },
                ),
                const SizedBox(height: 50),
                const TextSeparatorSidebar(text: 'Exit'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton.icon(
                    label: const Text("Salir", style: TextStyle(color: Colors.white)),
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
        const FooterSidebar(isMinimize: false),
      ],
    );
  }
}

class SidebarMimimized extends StatelessWidget {
  const SidebarMimimized({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: 80,
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
                const LogoSidebar(isMenuIcon: true),
                const ProfileSidebar(isMenuIcon: true),
                BlocBuilder<MenuSidebarBloc, MenuSidebarState>(
                  builder: (BuildContext context, MenuSidebarState stateModulo) {
                    final List<PaquetesSidebar> paquetesSidebar = <PaquetesSidebar>[];
                    for (final PaqueteMenu paquete in stateModulo.paquetes) {
                      paquetesSidebar.add(
                        PaquetesSidebar(
                          paquete: paquete,
                          isMimimize: true,
                        ),
                      );
                    }
                    return Column(children: paquetesSidebar);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: OutlinedButton.icon(
                    label: const SizedBox(),
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
        const FooterSidebar(isMinimize: true),
      ],
    );
  }
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
