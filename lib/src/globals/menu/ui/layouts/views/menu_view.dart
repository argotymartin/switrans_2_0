import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/shared/widgets/panels/card_expansion_panel.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: const <Widget>[
        Text('Menu Principal', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        CardExpansionPanel(
          icon: Icons.menu,
          title: 'Menu',
          child: Column(
            children: <Widget>[
              Text('Aca va a ser el menu'),
            ],
          ),
        ),
      ],
    );
  }
}
