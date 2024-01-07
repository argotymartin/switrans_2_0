import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Menu Principal', style: CustomLabels.h1),
        const SizedBox(height: 10),
        const WhiteCard(
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
