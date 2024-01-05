import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Dashboard', style: CustomLabels.h1),
        const SizedBox(height: 10),
        const WhiteCard(
          title: 'Sales Statistics',
          child: Column(
            children: [
              Icon(IconData(0xe03a, fontFamily: 'MaterialIcons')),
              Icon(IconData(0xee2c, fontFamily: 'MaterialIcons')),
              //Icon(),
              //Icon(),
              Text('Hola Mundo............'),
            ],
          ),
        ),
      ],
    );
  }
}
