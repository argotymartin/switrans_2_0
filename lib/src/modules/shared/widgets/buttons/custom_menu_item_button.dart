import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/models/models_shared.dart';

class CustomMenuItemButton extends StatefulWidget {
  const CustomMenuItemButton({super.key, required this.entries, required this.indexSelectedDefault});
  final List<EntryMenu> entries;
  final int indexSelectedDefault;

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
        .map((e) => MenuEntry(icon: Icons.circle_outlined, label: e.title, onPressed: () => setState(() => _lastSelection = e.title)))
        .toList();
    return Column(
      children: <Widget>[MenuBar(children: MenuEntry.build(_getMenus(menus)))],
    );
  }

  List<MenuEntry> _getMenus(menuChildren) {
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: _lastSelection,
        icon: Icons.list,
        menuChildren: menuChildren,
      ),
    ];
    return result;
  }
}

class MenuEntry {
  const MenuEntry({
    required this.label,
    this.onPressed,
    this.menuChildren,
    required this.icon,
  }) : assert(menuChildren == null || onPressed == null, 'onPressed is ignored if menuChildren are provided');
  final String label;
  final IconData icon;

  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;

  static List<Widget> build(List<MenuEntry> selections) {
    Widget buildSelection(MenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: MenuEntry.build(selection.menuChildren!),
          child: Row(
            children: [
              Icon(selection.icon),
              const SizedBox(width: 8),
              Text(selection.label),
            ],
          ),
        );
      }
      return MenuItemButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
        leadingIcon: const Icon(Icons.circle_outlined),
        onPressed: selection.onPressed,
        child: Row(
          children: [
            Text(selection.label),
          ],
        ),
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }
}
