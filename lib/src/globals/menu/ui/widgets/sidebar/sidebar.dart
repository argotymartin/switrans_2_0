import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/data/models/paquete_model.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/paquete.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
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
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        LogoSidebar(isMenuIcon: state.isMinimize),
                        ProfileSidebar(isMenuIcon: state.isMinimize),
                        state.isMinimize ? const SizedBox() : const SizedBox(height: 16),
                        BlocBuilder<ModuloBloc, ModuloState>(
                          builder: (context, stateModulo) {
                            List<PaquetesSidebar> modulos = [];
                            for (Paquete paquete in stateModulo.paquetes) {
                              modulos.add(PaquetesSidebar(
                                paquete: paquete,
                                isMimimize: state.isMinimize,
                                onPressed: () {},
                              ));
                            }
                            return Column(children: modulos);
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
                  Container(
                    height: size.height * 0.08,
                    padding: state.isMinimize ? null : const EdgeInsets.symmetric(horizontal: 54),
                    width: state.isMinimize ? 80 : 270,
                    color: Theme.of(context).colorScheme.primary,
                    child: state.isMinimize
                        ? Icon(Icons.double_arrow_outlined, color: Colors.white.withOpacity(0.3))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.forum_outlined, color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.6), size: 20),
                              Icon(Icons.telegram_sharp, color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.6), size: 20),
                              Icon(Icons.call_outlined, color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.6), size: 20),
                            ],
                          ),
                  )
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
