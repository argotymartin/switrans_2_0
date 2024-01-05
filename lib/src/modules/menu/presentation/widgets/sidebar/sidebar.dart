import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/menu/menu_bloc.dart';
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
                        MenuItemSidebar(
                          text: 'Aplication Intel',
                          icon: Icons.document_scanner_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Orders',
                          icon: Icons.shopping_bag_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Analitycs',
                          icon: Icons.shopping_bag_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Categories',
                          icon: Icons.layers_clear_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Products',
                          icon: Icons.dashboard_customize_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Discount',
                          icon: Icons.money_off_csred_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Custumer',
                          icon: Icons.person_pin_circle_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        state.isOpenMenuIcon ? const SizedBox() : const SizedBox(height: 30),
                        state.isOpenMenuIcon ? const SizedBox() : const TextSeparatorSidebar(text: 'TOOLS & COMPONENTS'),
                        MenuItemSidebar(
                          text: 'Icons',
                          icon: Icons.list,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Marketing',
                          icon: Icons.mark_email_read_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Campanign',
                          icon: Icons.note_add_outlined,
                          isMenuIcon: state.isOpenMenuIcon,
                          onPressed: () {},
                        ),
                        MenuItemSidebar(
                          text: 'Black',
                          icon: Icons.post_add_outlined,
                          onPressed: () {},
                          isMenuIcon: state.isOpenMenuIcon,
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
