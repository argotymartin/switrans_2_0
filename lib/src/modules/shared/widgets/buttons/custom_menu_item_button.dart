import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/models/models_shared.dart';

class CustomMenuItemButton extends StatefulWidget {
  final List<EntryMenu> entries;
  final int indexSelectedDefault;
  const CustomMenuItemButton({super.key, required this.entries, required this.indexSelectedDefault})
      : assert(indexSelectedDefault <= (entries.length - 1),
            'El index $indexSelectedDefault esta fuera del rango de macimo de entries: ${entries.length - 1}');

  @override
  State<CustomMenuItemButton> createState() => _MyMenuBarState();
}

class _MyMenuBarState extends State<CustomMenuItemButton> {
  String _lastSelection = "";
  @override
  void initState() {
    _lastSelection = widget.entries[widget.indexSelectedDefault].title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menus = widget.entries
        .map((e) => MenuEntry(context: context, label: e.title, onPressed: () => setState(() => _lastSelection = e.title)))
        .toList();

    return MenuBar(
      style: MenuStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).primaryColor)),
      ),
      children: [
        SubmenuButton(
          leadingIcon: Icon(Icons.list_outlined, color: Theme.of(context).primaryColor),
          trailingIcon: Icon(Icons.expand_more_outlined, color: Theme.of(context).primaryColor),
          menuChildren: buildMenuEntry(menus),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              key: GlobalKey(),
              _lastSelection,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildMenuEntry(List<MenuEntry> selections) {
    Widget buildSelection(MenuEntry selection) {
      return MenuItemButton(
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
        leadingIcon: Icon(Icons.circle_outlined, color: Theme.of(selection.context).primaryColor),
        onPressed: selection.onPressed,
        trailingIcon: const SizedBox(width: 24),
        child: Text(selection.label),
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }
}

class MenuEntry {
  const MenuEntry({
    required this.label,
    this.onPressed,
    this.menuChildren,
    required this.context,
  }) : assert(menuChildren == null || onPressed == null, 'onPressed is ignored if menuChildren are provided');
  final String label;
  final BuildContext context;

  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;
}
