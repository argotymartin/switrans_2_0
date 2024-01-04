import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/logo.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/menu_item.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/profile.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  final bool isIcon;
  const Sidebar({super.key, this.isIcon = false});

  void navigateTo(String routeName) {
    //NavigationService.navigateTo(routeName);
    //SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    //final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: isIcon ? 100 : 270,
          height: size.height * 0.95,
          decoration: buildBoxDecoration(),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const Logo(),
              const Profile(),
              const SizedBox(height: 16),
              MenuItem(
                //isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
                text: 'Aplication Intel',
                icon: Icons.document_scanner_outlined,
                onPressed: () {},
              ),
              MenuItem(text: 'Orders', icon: Icons.shopping_bag_outlined, onPressed: () {}),
              MenuItem(text: 'Analitycs', icon: Icons.shopping_bag_outlined, onPressed: () {}),
              MenuItem(text: 'Categories', icon: Icons.layers_clear_outlined, onPressed: () {}),
              MenuItem(text: 'Products', icon: Icons.dashboard_customize_outlined, onPressed: () {}),
              MenuItem(text: 'Discount', icon: Icons.money_off_csred_outlined, onPressed: () {}),
              MenuItem(text: 'Custumer', icon: Icons.person_pin_circle_outlined, onPressed: () {}),
              const SizedBox(height: 30),
              const TextSeparator(text: 'TOOLS & COMPONENTS'),
              MenuItem(
                  //isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
                  text: 'Icons',
                  icon: Icons.list,
                  onPressed: () {}),
              MenuItem(text: 'Marketing', icon: Icons.mark_email_read_outlined, onPressed: () {}),
              MenuItem(text: 'Campanign', icon: Icons.note_add_outlined, onPressed: () {}),
              MenuItem(
                //isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
                text: 'Black',
                icon: Icons.post_add_outlined,
                onPressed: () {},
              ),
              const SizedBox(height: 50),
              const TextSeparator(text: 'Exit'),
              MenuItem(text: 'Logout', icon: Icons.exit_to_app_outlined, onPressed: () {}),
            ],
          ),
        ),
        Container(
          height: size.height * 0.05,
          width: isIcon ? 100 : 270,
          color: const Color(0xff2b4c81),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message_outlined, color: Colors.white.withOpacity(0.3)),
              const SizedBox(width: 8),
              Icon(Icons.telegram_sharp, color: Colors.white.withOpacity(0.3)),
              const SizedBox(width: 8),
              Icon(Icons.call_outlined, color: Colors.white.withOpacity(0.3)),
            ],
          ),
        )
      ],
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
