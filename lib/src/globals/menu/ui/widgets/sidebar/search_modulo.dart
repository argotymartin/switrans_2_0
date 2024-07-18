import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/menu_sidebar/menu_sidebar_bloc.dart';

class SearchModulo extends StatefulWidget {
  const SearchModulo({super.key});

  @override
  State<SearchModulo> createState() => _SearchModuloState();
}

class _SearchModuloState extends State<SearchModulo> {
  bool isPressed = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final MenuSidebarBloc menusidebar = context.read<MenuSidebarBloc>();

    return Container(
      padding: const EdgeInsets.all(8),
      color: colorScheme.primary.withOpacity(0.2),
      child: Align(
        child: TextField(
          cursorColor: Colors.white,
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (String value) async {
            await Future<dynamic>.delayed(const Duration(milliseconds: 200));
            menusidebar.add(SearchMenuSidebarEvent(value));
            setState(() => isPressed = true);
          },
          decoration: InputDecoration(
            fillColor: Colors.transparent.withOpacity(0.2),
            filled: true,
            hintStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(maxHeight: 38, minHeight: 32),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).canvasColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).canvasColor,
                width: 2,
              ),
            ),
            hintText: "Buscar por modulo..",
            suffixIcon: IconButton(
              icon: Icon(isPressed ? Icons.filter_alt_off : Icons.filter_alt),
              color: Colors.white,
              onPressed: () async {
                setState(() => isPressed = false);
                controller.text = "";
                await Future<dynamic>.delayed(const Duration(milliseconds: 200));
                menusidebar.add(const SearchMenuSidebarEvent(""));
              },
            ),
          ),
        ),
      ),
    );
  }
}
