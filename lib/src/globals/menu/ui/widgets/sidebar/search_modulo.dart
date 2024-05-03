import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/menu_sidebar/menu_sidebar_bloc.dart';

class SearchModulo extends StatelessWidget {
  const SearchModulo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    TextEditingController controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(8),
      color: colorScheme.onPrimaryContainer.withOpacity(0.1),
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          cursorColor: Colors.white,
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (value) async {
            final menusidebar = context.read<MenuSidebarBloc>();
            await Future.delayed(const Duration(milliseconds: 500));

            menusidebar.add(SearchMenuSidebarEvent(value));
          },
          decoration: InputDecoration(
            fillColor: colorScheme.onPrimaryContainer,
            filled: true,
            hintStyle: TextStyle(color: colorScheme.outlineVariant, fontSize: 14, fontWeight: FontWeight.w300),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            constraints: const BoxConstraints(maxHeight: 38, minHeight: 32),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            hintText: "Buscar por modulo..",
            suffixIcon: Icon(
              Icons.filter_alt_off,
              color: colorScheme.outlineVariant,
            ),
          ),
        ),
      ),
    );
  }
}
