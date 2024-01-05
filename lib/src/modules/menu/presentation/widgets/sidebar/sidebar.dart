import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/domain/entities/modulo.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/menu/menu_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/widgets/widgets.dart';

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
                    width: state.isOpenMenuIcon ? 80 : 270,
                    height: size.height * 0.92,
                    decoration: buildBoxDecoration(),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        LogoSidebar(isMenuIcon: state.isOpenMenuIcon),
                        ProfileSidebar(isMenuIcon: state.isOpenMenuIcon),
                        state.isOpenMenuIcon ? const SizedBox() : const SizedBox(height: 16),
                        BlocBuilder<ModuloBloc, ModuloState>(
                          builder: (context, stateModulo) {
                            List<MenuItemSidebar> modulos = [];
                            for (Modulo modulo in stateModulo.modulos) {
                              modulos.add(MenuItemSidebar(
                                icon: IconData(int.parse(modulo.moduloIcono), fontFamily: 'MaterialIcons'),
                                onPressed: () {},
                                text: modulo.moduloTexto,
                                isMenuIcon: state.isOpenMenuIcon,
                              ));
                            }
                            return Column(
                              children: modulos,
                            );
                          },
                        ),
                        state.isOpenMenuIcon ? const SizedBox() : const SizedBox(height: 50),
                        state.isOpenMenuIcon ? const SizedBox() : const TextSeparatorSidebar(text: 'Exit'),
                        MenuItemSidebar(
                          text: 'Logout',
                          icon: Icons.exit_to_app_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.08,
                    padding: state.isOpenMenuIcon ? null : const EdgeInsets.symmetric(horizontal: 54),
                    width: state.isOpenMenuIcon ? 80 : 270,
                    color: const Color(0xff2b4c81),
                    child: state.isOpenMenuIcon
                        ? Icon(Icons.double_arrow_outlined, color: Colors.white.withOpacity(0.3))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.forum_outlined, color: Colors.white.withOpacity(0.3), size: 20),
                              Icon(Icons.telegram_sharp, color: Colors.white.withOpacity(0.3), size: 20),
                              Icon(Icons.call_outlined, color: Colors.white.withOpacity(0.3), size: 20),
                            ],
                          ),
                  )
                ],
              )
            : const SizedBox();
      },
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xff2b4c81),
          Color.fromARGB(255, 56, 84, 129),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
        )
      ],
    );
  }
}
