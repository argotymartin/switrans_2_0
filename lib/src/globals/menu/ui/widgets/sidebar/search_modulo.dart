import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/menu_sidebar/menu_sidebar_bloc.dart';

class SearchModulo extends StatelessWidget {
  const SearchModulo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (value) async {
            final menusidebar = context.read<MenuSidebarBloc>();
            await Future.delayed(const Duration(milliseconds: 500));

            menusidebar.add(SearchMenuSidebarEvent(value));
          },
        ));
  }
}
