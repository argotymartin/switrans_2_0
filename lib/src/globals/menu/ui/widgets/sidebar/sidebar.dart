import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/sidebar/footer_sidebar.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return state.isOpenMenu
            ? Column(
                children: [
                  Container(
                    width: state.isMinimize ? 80 : kWidthSidebar,
                    height: size.height * 0.92,
                    decoration: buildBoxDecoration(context),
                    child: Theme(
                      data: ThemeData(
                        scrollbarTheme: ScrollbarThemeData(
                          thickness: MaterialStateProperty.all(8.0),
                        ),
                      ),
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        children: [
                          LogoSidebar(isMenuIcon: state.isMinimize),
                          ProfileSidebar(isMenuIcon: state.isMinimize),
                          state.isMinimize ? const SizedBox() : const SizedBox(height: 16),
                          state.isMinimize ? const SizedBox() : const TextSeparatorSidebar(text: 'Paquetes'),
                          BlocBuilder<ModuloBloc, ModuloState>(
                            builder: (context, stateModulo) {
                              List<PaquetesSidebar> paquetesSidebar = [];
                              for (Paquete paquete in stateModulo.paquetes) {
                                paquetesSidebar.add(PaquetesSidebar(
                                  paquete: paquete,
                                  isMimimize: state.isMinimize,
                                  onPressed: () {},
                                ));
                              }
                              return Column(children: paquetesSidebar);
                            },
                          ),
                          state.isMinimize ? const SizedBox() : const SizedBox(height: 50),
                          state.isMinimize ? const SizedBox() : const TextSeparatorSidebar(text: 'Exit'),
                          PaquetesSidebar(
                            paquete: PaqueteModel(
                              id: "",
                              nombre: "Logout",
                              codigo: 1,
                              icono: "0xf031",
                              visible: true,
                              modulos: [],
                              path: '/logout',
                            ),
                            isMimimize: state.isMinimize,
                            onPressed: () {
                              context.read<AuthBloc>().onLogoutAuthEvent();
                              context.go(AppRouter.login);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  FooterSidebar(isMinimize: state.isMinimize)
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
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
      ],
    ));
  }
}
