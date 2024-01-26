import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Menu Principal', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        const WhiteCard(
          icon: Icons.menu,
          title: 'Menu',
          child: Column(
            children: [
              Text('Aca va a ser el menu'),
            ],
          ),
        ),
      ],
    );
  }
}
