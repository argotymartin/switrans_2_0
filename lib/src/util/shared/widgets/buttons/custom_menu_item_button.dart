import 'package:flutter/material.dart';

class CustomMenuItemButton extends StatefulWidget {
  final List<MenuEntry> entries;
  final int indexSelectedDefault;
  final Function(MenuEntry result)? onPressed;
  const CustomMenuItemButton({
    required this.entries,
    required this.indexSelectedDefault,
    this.onPressed,
    super.key,
  }) : assert(
          indexSelectedDefault <= (entries.length - 1),
          'El index $indexSelectedDefault esta fuera del rango de macimo de entries: ${entries.length - 1}',
        );

  @override
  State<CustomMenuItemButton> createState() => _MyMenuBarState();
}

class _MyMenuBarState extends State<CustomMenuItemButton> {
  String _lastSelection = "";
  @override
  void initState() {
    _lastSelection = widget.entries[widget.indexSelectedDefault].label;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menus = widget.entries
        .map(
          (entry) => MenuEntry(
            value: 1,
            label: entry.label,
            onPressed: () {
              if (_lastSelection != entry.label) {
                setState(() => _lastSelection = entry.label);
                widget.onPressed?.call(entry);
              }
            },
          ),
        )
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
          menuChildren: buildMenuEntry(menus, context),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: SizedBox(
              child: Text(
                key: GlobalKey(),
                _lastSelection,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildMenuEntry(List<MenuEntry> selections, BuildContext context) {
    Widget buildSelection(MenuEntry selection) {
      return MenuItemButton(
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
        leadingIcon: Icon(Icons.circle_outlined, color: Theme.of(context).colorScheme.onPrimaryContainer),
        onPressed: selection.onPressed,
        trailingIcon: const SizedBox(width: 24),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(selection.label),
        ),
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }
}

class MenuEntry {
  const MenuEntry({
    required this.label,
    required this.value,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;
  final int value;
}
