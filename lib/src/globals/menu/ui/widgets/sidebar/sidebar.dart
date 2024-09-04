import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/constans/constants.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete_menu.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/footer_sidebar.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/search_modulo.dart';

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
        if (state.isOpenMenu!) {
          return const SidebarExpanded();
        } else if (state.isMinimize!) {
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
    final int? themeMode = context.read<ThemeCubit>().state.themeMode;

    Color color;
    if (themeMode == 1) {
      color = Colors.white;
    } else if (themeMode == 2) {
      color = Colors.white;
    } else {
      color = Theme.of(context).colorScheme.onPrimaryContainer;
    }

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
                BlocBuilder<MenuBloc, MenuState>(
                  builder: (BuildContext context, MenuState stateModulo) {
                    final List<PaquetesSidebar> paquetesSidebar = <PaquetesSidebar>[];
                    for (final PaqueteMenu paquete in stateModulo.paquetes!) {
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
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll<BorderSide>(
                        BorderSide(color: Theme.of(context).canvasColor, width: 2),
                      ),
                    ),
                    label: Text("Salir", style: TextStyle(color: color)),
                    onPressed: () {
                      context.read<AuthBloc>().add(const LogoutAuthEvent());
                      context.go(AppRouter.login);
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: color,
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
    final int? themeMode = context.read<ThemeCubit>().state.themeMode;

    Color color;
    if (themeMode == 1) {
      color = Colors.white;
    } else if (themeMode == 2) {
      color = Colors.white;
    } else {
      color = Colors.black;
    }

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
                BlocBuilder<MenuBloc, MenuState>(
                  builder: (BuildContext context, MenuState stateModulo) {
                    final List<PaquetesSidebar> paquetesSidebar = <PaquetesSidebar>[];
                    for (final PaqueteMenu paquete in stateModulo.paquetes!) {
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
                      context.read<AuthBloc>().add(const LogoutAuthEvent());
                      context.go(AppRouter.login);
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: color,
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
  final int? themeMode = context.read<ThemeCubit>().state.themeMode;
  List<Color> colors = <Color>[];
  if (themeMode == 1) {
    colors = <Color>[
      Theme.of(context).canvasColor.withOpacity(0.8),
      Color.alphaBlend(Colors.black.withOpacity(0.3), Theme.of(context).canvasColor),
    ];
  } else if (themeMode == 2) {
    colors = <Color>[
      Theme.of(context).colorScheme.surfaceContainerHigh,
      Theme.of(context).colorScheme.surfaceContainer,
    ];
  } else {
    colors = <Color>[
      Colors.white,
      Colors.white,
    ];
  }
  return BoxDecoration(
    gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: colors),
    boxShadow: <BoxShadow>[
      BoxShadow(color: Theme.of(context).colorScheme.shadow.withOpacity(0.2), blurRadius: 22, offset: const Offset(2, 0)),
    ],
  );
}
