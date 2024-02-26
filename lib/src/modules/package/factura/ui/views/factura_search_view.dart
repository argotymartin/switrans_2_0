import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/buttons/custom_menu_item_button.dart';

class FacturaSearchView extends StatelessWidget {
  const FacturaSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    List<EntryMenu> entryMenus = [
      EntryMenu(title: "Tipo 11"),
      EntryMenu(title: "Tipo 12"),
    ];
    return MaterialApp(
      home: CustomMenuItemButton(entries: entryMenus, indexSelectedDefault: 0),
    );
  }
}
