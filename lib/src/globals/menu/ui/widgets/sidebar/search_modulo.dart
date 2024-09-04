import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

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
    final MenuBloc menuBloc = context.read<MenuBloc>();
    final ThemeState themeState = context.watch<ThemeCubit>().state;
    final Color? color = themeState.color;
    Color colorText;
    if (themeState.themeMode == 1) {
      colorText = Colors.white;
    } else if (themeState.themeMode == 2) {
      colorText = Colors.white;
    } else {
      colorText = Colors.black;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      color: color!.withOpacity(0.2),
      child: Align(
        child: TextField(
          cursorColor: colorText,
          controller: controller,
          style: TextStyle(
            color: colorText,
          ),
          onChanged: (String value) async {
            await Future<dynamic>.delayed(const Duration(milliseconds: 200));
            menuBloc.add(SearchMenuEvent(value));
            setState(() => isPressed = true);
          },
          decoration: InputDecoration(
            fillColor: Colors.transparent.withOpacity(0.2),
            filled: true,
            hintStyle: TextStyle(color: colorText, fontSize: 14, fontWeight: FontWeight.w300),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(maxHeight: 38, minHeight: 32),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: color,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: color,
                width: 2,
              ),
            ),
            hintText: "Buscar por modulo..",
            suffixIcon: IconButton(
              icon: Icon(isPressed ? Icons.filter_alt_off : Icons.filter_alt),
              color: colorText,
              onPressed: () async {
                setState(() => isPressed = false);
                controller.text = "";
                await Future<dynamic>.delayed(const Duration(milliseconds: 200));
                menuBloc.add(const SearchMenuEvent(""));
              },
            ),
          ),
        ),
      ),
    );
  }
}
